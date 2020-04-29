//
//  ViewController.swift
//  Pokedex
//
//  Created by Leonardo Diaz on 4/27/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var pokeSearchBar: UISearchBar!
    @IBOutlet weak var pokeImageView: UIImageView!
    @IBOutlet weak var pokeNameLabel: UILabel!
    @IBOutlet weak var pokeID: UILabel!
    @IBOutlet weak var pokeTypeLabel: UILabel!
    @IBOutlet weak var randomButton: UIButton!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeSearchBar.delegate = self
        updateView()
    }
    @IBAction func randomButtonPressed(_ sender: Any) {
        let randomPokemon = String(Int.random(in: 1...802))
        PokemonController.fetchPokemon(searchTerm: randomPokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSprite(pokemon: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK: - Methods
    func fetchSprite(pokemon: Pokemon){
        PokemonController.fetchSprite(pokemon: pokemon) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let sprite):
                    self.pokeImageView.image = sprite
                    self.pokeNameLabel.text = pokemon.name.capitalized
                    self.pokeID.text = "ID: \(pokemon.id)"
                    var pokemonType = String()
                    pokemon.types.forEach { (type) in
                        pokemonType += type.type.name.lowercased().capitalized + " "
                    }
                    self.pokeTypeLabel.text = ("Type: \(pokemonType)")
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    private func updateView() {
        randomButton.layer.cornerRadius = 15
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text else {return}
        PokemonController.fetchPokemon(searchTerm: searchTerm) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.fetchSprite(pokemon: pokemon)
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

