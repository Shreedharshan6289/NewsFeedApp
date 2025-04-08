//
//  APIManager.swift
//  NewsFeedApp
//
//  Created by Shreedharshan on 13/02/25.
//

import Foundation
import Alamofire


class APIManager {
    
    static let shared = APIManager()
    
    let baseURL = "https://newsapi.org/v2/top-headlines"
    let apiKey = "e80bea08c6f24e73b2d0bd939aad942b"
    
    var isMockingEnabled = false
    var mockResponse: [String: Any]? = nil
    
    init() {}
    
    static func isConnectedToNetwork() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func get(parameters: [String: String], completion: @escaping (Result<[String: Any], Error>) -> Void) {
        if isMockingEnabled, let mockResponse = mockResponse {
            completion(.success(mockResponse))
            return
        }
        
        guard APIManager.isConnectedToNetwork() else {
            completion(.failure(NetworkError.noInternet))
            return
        }
        
        AF.request(baseURL, method: .get, parameters: parameters, encoding: URLEncoding.default)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            completion(.success(json))
                        } else {
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    } catch {
                        completion(.failure(NetworkError.parsingFailed(error.localizedDescription)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

enum NetworkError: Error {
    case noInternet
    case invalidResponse
    case parsingFailed(String)
}

