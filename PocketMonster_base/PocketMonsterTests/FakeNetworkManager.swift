//
//  FakeNetworkManager.swift
//  PocketMonsterTests
//
//  Created by Bryan Andres  Almeida Flores on 02/05/2022.
//

import Foundation
@testable import PocketMonster

class FakeNetworkManager : NetworkManagerProtocol {
    var url: String = ""
    
    func getResponseType<ResponseType>(_ type: ResponseType.Type) async throws -> ResponseType where ResponseType : Decodable {
        
        var jsonName = " "
        
        if type  == PokemonResponse.self {
            jsonName = "pokemon" }
        
        if type == PokemonResponse.self{
            jsonName = "abilities"
            
        }
            let data = try getJsonfakepokemon (name: jsonName)
            let result = try JSONDecoder().decode(ResponseType.self, from: data)
            return result
            
        }

    
    
    
    func getData() async throws -> Data {
        return Data ()
    }
    
   func getJsonfakepokemon(name: String) throws -> Data {
        
       guard let urlPath = Bundle(for: FakeNetworkManager.self).url(forResource: name, withExtension: "json")
        else { return Data( )}
        
        let data = try Data(contentsOf: urlPath)
        return data
    }
    
    
    
}

