//
//  LoginViewModel.swift
//  EsewaClone
//
//  Created by Alin Khatri on 04/07/2023.
//

import Foundation

final class LoginViewModel {
    
    var user: UserModel?
    var eventHandler: ((_ event: Event) -> Void)?
    
    func loginUser(parameter: LoginRequest) {
        self.eventHandler?(.loading)

        APIManager.shared.request(modelType: UserModel.self, type: AuthEndPoints.login(authUser: parameter)) { result in
            
            self.eventHandler?(.stopLoading)

            switch result {
            case .success(let user):
                self.eventHandler?(.loggedInUser(user: user))
                
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    

}

extension LoginViewModel {

    enum Event {
        case loading
        case stopLoading
        case loggedInUser(user: UserModel)
        case error(Error?)
    }
}

