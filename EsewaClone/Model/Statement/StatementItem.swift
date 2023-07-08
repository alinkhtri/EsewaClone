//
//  Statement.swift
//  EsewaClone
//
//  Created by Alin Khatri on 25/06/2023.
//

import Foundation

struct StatementData: Codable {
    var data: [StatementItem]
}

struct StatementItem: Codable {
    let icon: String
    let message: String
    let datetime: String
    let balance: Double
}
