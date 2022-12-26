//
//  Detail.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct DetailDataWrapper: Codable {
    let data: DetailDataContainer?
}

struct DetailDataContainer: Codable {
    let results: [Detail]?
}

struct Detail: Codable, Hashable {
    let id: Int?
    let title: String?
    let urls: [Url]?
    let thumbnail: Image?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Detail, rhs: Detail) -> Bool {
        lhs.id == rhs.id
    }
}
