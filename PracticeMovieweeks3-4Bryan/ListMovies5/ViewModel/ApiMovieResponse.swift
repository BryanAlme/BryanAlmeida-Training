//
//  ApiMovie.swift
//  ListMovies5
//
//  Created by Bryan Andres  Almeida Flores on 30/04/2022.
//

import Foundation

struct ApiMovieResponse: Codable {
    let results: [Movies]
}

struct Movies: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    let overview: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
    }
    
}

struct MovieDetail: Codable {
    let id:Int
    let productionCompanies:[ProductionCompany]
    
    enum CodingKeys:String, CodingKey{
        case id
        case productionCompanies = "production_companies"
    }
}



struct MovieItem: Codable {
    var row: Int
    var title : String?
    var overview : String?
    var imageData : Data?
    var isFavourite : Bool?
}

struct ProductionCompany:Codable{
    let id:Int
    let logoPath:String?
    let name:String
    let country:String
    
    enum CodingKeys:String, CodingKey{
        case id
        case logoPath = "logo_path"
        case name
        case country = "origin_country"
    }
}




