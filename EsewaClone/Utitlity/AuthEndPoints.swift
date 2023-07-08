//
//  AuthEndPoints.swift
//  EsewaClone
//
//  Created by Alin Khatri on 03/07/2023.
//

import Foundation

enum AuthEndPoints {
    case login(authUser: LoginRequest)
    case register(authUser: LoginRequest)
}

extension AuthEndPoints: EndPointType {
    
    var header: [String : String]? {
        return APIManager.commonHeader
    }
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .register:
            return "register"
        }
    }
    
    var baseURL: String {
        switch self {
        case .login:
            return "https://dummyjson.com/auth/"
        case .register:
            return "https://dummyjson.com/auth/"
        }
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .login:
            return .post
        case .register:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self {
        case .login(let authUser):
            return authUser
        case .register(let authUser):
            return authUser
        }
    }
}
