//
//  LoginViewModel.swift
//  EsewaClone
//
//  Created by Alin Khatri on 04/07/2023.
//

import Foundation
import Combine

final class LoginViewModel {
    var user: UserModel?
    
    var eventHandler: ((Event) -> Void)?
    private var cancellables: Set<AnyCancellable> = []
    
    func loginUser(parameter: LoginRequest) {
        self.eventHandler?(.loading)
        
        APIManager.shared.request(modelType: UserModel.self, type: AuthEndPoints.login(authUser: parameter))
            .sink { [weak self] completion in
                guard let self = self else { return }
                self.eventHandler?(.stopLoading)
                
                if case let .failure(error) = completion {
                    self.eventHandler?(.error(error))
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
                self.storeTokenInKeychain(user.token!)
                self.eventHandler?(.loggedInUser(user: user))
            }
            .store(in: &cancellables)
    }
    
    private func retrieveTokenFromKeychain() -> String? {
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
    
    private func storeTokenInKeychain(_ token: String) {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "JWTToken",
        ]

        // Check if a token already exists in the Keychain
        if retrieveTokenFromKeychain() != nil {
            let updateQuery: [String: Any] = [
                kSecValueData as String: token.data(using: .utf8)!
            ]
            
            let status = SecItemUpdate(keychainQuery as CFDictionary, updateQuery as CFDictionary)
            if status != errSecSuccess {
                print("Failed to update token in Keychain")
            }
        } else {
            let addQuery: [String: Any] = [
                kSecValueData as String: token.data(using: .utf8)!,
                kSecAttrAccessible as String: kSecAttrAccessibleWhenUnlocked
            ]
            
            let status = SecItemAdd(addQuery as CFDictionary, nil)
            if status != errSecSuccess {
                print("Failed to store token in Keychain")
            }
        }
    }

}

extension LoginViewModel {
    enum Event {
        case loading
        case stopLoading
        case loggedInUser(user: UserModel)
        case error(DataError)
    }
}
