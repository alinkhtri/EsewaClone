//
//  APIManager.swift
//  ProductMVVM
//
//  Created by Alin Khatri on 03/07/2023.
//

import Foundation
import Combine

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case invalidData
    case message(_ error: Error?)
}

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func request<T: Codable>(
        modelType: T.Type,
        type: EndPointType
    ) -> Future<T, DataError> {
        return Future<T, DataError> { promise in
            guard let url = type.url else {
                promise(.failure(.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = type.method.rawValue
            
            if let parameters = type.body {
                request.httpBody = try? JSONEncoder().encode(parameters)
            }
            
            request.allHTTPHeaderFields = type.header
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
                    promise(.failure(.invalidData))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    promise(.failure(.invalidResponse))
                    return
                }
                
                do {
                    let user = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(user))
                } catch {
                    promise(.failure(.message(error)))
                }
            }.resume()
        }
    }
    
    static var commonHeader: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
