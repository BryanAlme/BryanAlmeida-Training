//
//  NetworkManager.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 30/04/2022.

import Foundation
import Combine

protocol NetworkManager {
    func getModel<Model: Decodable>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, NetworkErrors>
    func getData(from url: String, completionHandler: @escaping (Data?) -> Void)
}

class MainNetworkManager: NetworkManager {
    
    func getModel<Model: Decodable>(_ model: Model.Type, from url: String) -> AnyPublisher<Model, NetworkErrors> {
        
        guard let url = URL(string: url)
        else { return Fail<Model, NetworkErrors>(error: .badURL).eraseToAnyPublisher() }
        
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .map { result -> Data in
                return result.data
            }
            .decode(type: model, decoder: JSONDecoder())
            .mapError { error -> NetworkErrors in
                return .other(error)
            }
            .eraseToAnyPublisher()
    }
    
    func getData(from url: String, completionHandler: @escaping (Data?) -> Void) {
        
        guard let url = URL(string: url) else {
            completionHandler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completionHandler(data)
        }
        .resume()
    }
    
}



