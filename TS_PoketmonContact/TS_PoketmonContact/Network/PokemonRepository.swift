//
//  PokemonRepository.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/9/24.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func fetchPokemon(frontDefault: Int, completion: @escaping (Result<PokemonResponse, Error>) -> Void)
}

final class PokemonRepository: PokemonRepositoryProtocol {
    private let networkService: NetworkService
    private let baseURL = "https://pokeapi.co/api/v2/pokemon/"
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func fetchPokemon(frontDefault: Int, completion: @escaping (Result<PokemonResponse, any Error>) -> Void) {
        let url = "\(baseURL)\(frontDefault)"
        print("repository url \(url)")
        networkService.networkRequest(url: url, method: .get, parameters: nil) { (result: Result<PokemonResponse, Error>) in
            completion(result)
        }
    }
}
