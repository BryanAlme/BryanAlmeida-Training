//
//  URLs.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 30/04/2022.
//

import Foundation

enum NetworkURLs {
    static let popularMovies = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=6622998c4ceac172a976a1136b204df4"
    static let movieDetailBase = "https://api.themoviedb.org/3/movie/"
    static let apiKeyQueryParam = "?api_key=6622998c4ceac172a976a1136b204df4&language=en-US"
    
    static let imageBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let movieDataUrl = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&api_key=6622998c4ceac172a976a1136b204df4"
    
}

