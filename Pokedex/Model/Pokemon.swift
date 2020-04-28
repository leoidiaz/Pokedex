//
//  Pokemon.swift
//  Pokedex
//
//  Created by Leonardo Diaz on 4/27/20.
//  Copyright © 2020 Leonardo Diaz. All rights reserved.
//

import Foundation

struct Pokemon: Decodable {
    let name: String
    let id: Int
    let sprites: Sprite
}

struct Sprite: Decodable {
    let classicSprite: URL
    
    enum CodingKeys: String, CodingKey {
        case classicSprite = "front_default"
    }
}

