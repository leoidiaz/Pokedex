//
//  PokemonController.swift
//  Pokedex
//
//  Created by Leonardo Diaz on 4/27/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class PokemonController {
    static let baseURL = URL(string: "https://pokeapi.co/api/v2")
    static let pokemonEndPoint = "pokemon"
    
    static func fetchPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, PokemonError>) -> Void){
        // URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        let pokemonURL = baseURL.appendingPathComponent(pokemonEndPoint)
        let searchTermURL = pokemonURL.appendingPathComponent(searchTerm.lowercased())
        // Data Task
        URLSession.shared.dataTask(with: searchTermURL) { (data, _, error) in
            // Error
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            // Check for data
            guard let data = data else {return completion(.failure(.noData))}
            // Decode Data
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchSprite(pokemon: Pokemon, completion: @escaping (Result<UIImage, PokemonError>) -> Void) {
        let spriteURL = pokemon.sprites.classicSprite
        URLSession.shared.dataTask(with: spriteURL) { (data, _, error) in
            if let error = error {
                print(error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let sprite = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            return completion(.success(sprite))
        }.resume()
        
    }
}
