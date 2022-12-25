//
//  Comics.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct ComicList: Codable {
    let returned: Int?
    let items: [Comics]?
}

struct Comics: Codable {
    let resourceURI: URL?
    let name: String?
}
