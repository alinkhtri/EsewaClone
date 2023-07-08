//
//  EndPointType.swift
//  ProductMVVM
//
//  Created by Alin Khatri on 03/07/2023.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
}

protocol EndPointType {
    var path: String { get }
    var baseURL: String { get }
    var url: URL? { get }
    var method: HTTPMethods { get }
    var body: Encodable? { get }
    var header: [String: String]? { get }
}

