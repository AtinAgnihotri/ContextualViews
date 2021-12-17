//
//  Webservice.swift
//  ContextualViews
//
//  Created by Atin Aganihotri on 17/12/21.
//

import Foundation


struct HomepageResponse: Decodable {
    let cardGroups: [CardGroup]
}


public enum NetworkError: Error {
    case serverError
    case decodingError
    case domainError
    case urlError
}

class WebService {
    
    public static let shared = WebService()
    
    private init () {
        
    }
    
    func fetchHomepageConfig(onCompletion: @escaping (Result< HomepageResponse, NetworkError>) -> Void ) {
        guard let url = URL(string: Constants.URL.HOMEPAGE_CONFIG) else {
            DispatchQueue.main.async {
                onCompletion(.failure(.domainError))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    onCompletion(.failure(.serverError))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    onCompletion(.failure(.domainError))
                }
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let decodedData = try? decoder.decode(HomepageResponse.self, from: data) else {
                DispatchQueue.main.async {
                    onCompletion(.failure(.decodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                onCompletion(.success(decodedData))
            }
        }.resume()
        
        
    }
}
