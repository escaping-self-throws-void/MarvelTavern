//
//  File.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct SeriesList: Codable {
    let returned: Int?
    let items: [Series]?
}

struct Series: Codable {
    let resourceURI: URL?
    let name: String?
}
