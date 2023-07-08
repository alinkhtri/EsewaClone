//
//  UserModel.swift
//  EsewaClone
//
//  Created by Alin Khatri on 04/07/2023.
//

import Foundation

struct UserModel: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let token: String
}

