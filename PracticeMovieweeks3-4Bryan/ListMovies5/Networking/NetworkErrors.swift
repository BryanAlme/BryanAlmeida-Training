//
//  NetworkErrors.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 30/04/2022.
//

import Foundation

enum NetworkErrors: Error {
    case badURL
    case decodeError(Error)
    case networkError(Error)
    case other(Error)
}
