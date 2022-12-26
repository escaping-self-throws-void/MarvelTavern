//
//  Hero.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct HeroDataWrapper: Codable {
    let data: HeroDataContainer?
}

struct HeroDataContainer: Codable {
    let results: [Hero]?
}

struct Hero: Codable, Hashable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail: Image?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Hero, rhs: Hero) -> Bool {
        lhs.id == rhs.id
    }
}
