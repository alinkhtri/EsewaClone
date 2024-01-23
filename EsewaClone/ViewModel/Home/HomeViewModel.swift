//
//  HomeViewModel.swift
//  EsewaClone
//
//  Created by Alin Khatri on 07/07/2023.
//

import Foundation
import Combine
import JWTDecode

final class HomeViewModel {
    
    @Published var user: UserModel?
    
    var homeEventHandler: ((HomeEvent) -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    
    func retrieveTokenFromKeychain() -> String? {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "JWTToken",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var retrievedData: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &retrievedData)
        
        if status == errSecSuccess, let data = retrievedData as? Data {
            return String(data: data, encoding: .utf8)
        } else {
            return nil
        }
    }

    func retrieveTokenAndDecode() {
        // Retrieve the token from the keychain
        if let token = retrieveTokenFromKeychain() {
            // Decode the token and handle the result
            decodeToken(token)
        } else {
            // Handle case when token is not found
            print("Token not found")
        }
    }
    
    func decodeToken(_ token: String) {
        do {
            let jwt = try decode(jwt: token)
            
            if let user = extractUserFromToken(jwt) {
                let currentTimestamp = Date().timeIntervalSince1970
                let userExpTimestamp = TimeInterval(user.exp!)

                if userExpTimestamp > currentTimestamp {
                    self.user = user
                    homeEventHandler?(.success(user: user))
                } else {
                    // Expiry timestamp has already passed
                    let error = NSError(domain: "TokenExpired", code: 0, userInfo: nil)
                    homeEventHandler?(.error(error))
                }

            } else {

                let error = NSError(domain: "TokenDecodingError", code: 0, userInfo: nil)
                homeEventHandler?(.error(error))
            }
        } catch {
            homeEventHandler?(.error(error))
        }
    }
    
    private func extractUserFromToken(_ jwt: JWT) -> UserModel? {
        guard let userId = jwt.body["id"] as? Int,
              let username = jwt.body["username"] as? String,
              let email = jwt.body["email"] as? String,
              let firstName = jwt.body["firstName"] as? String,
              let lastName = jwt.body["lastName"] as? String,
              let gender = jwt.body["gender"] as? String,
              let image = jwt.body["image"] as? String else {
            return nil
        }
        
        let token = jwt.body["token"] as? String
        let iat = jwt.body["iat"] as? Int
        let exp = jwt.body["exp"] as? Int
        
        return UserModel(id: userId,
                         username: username,
                         email: email,
                         firstName: firstName,
                         lastName: lastName,
                         gender: gender,
                         image: image,
                         token: token,
                         iat: iat,
                         exp: exp)
    }
}


extension HomeViewModel {
    enum HomeEvent {
        case success(user: UserModel)
        case error(_ error: Error)
    }
}


