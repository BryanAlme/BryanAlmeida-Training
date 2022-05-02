//
//  PocketMonsterTests.swift
//  PocketMonsterTests
//
//  Created by Bryan Andres  Almeida Flores on 02/05/2022.
//

import XCTest
@testable import PocketMonster

class ViewModelTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testloadPokemons() async throws {
        
        // GIVEN
        
        let fakeNetworkManager = FakeNetworkManager()
        let viewModel = PokemonListViewModel(networkManager: fakeNetworkManager)
        
        
        // WHEN  if they are using async throws we need to use try await
        
      try await viewModel.loadPokemons()
         
        //THEN
        
        let pokemons = viewModel.pokemons
        XCTAssertEqual(pokemons.count, 100)
        
    }

    }

