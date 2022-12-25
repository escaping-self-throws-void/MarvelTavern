//
//  File.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct StoryList: Codable {
    let returned: Int?
    let items: [Story]?
}

struct Story: Codable {
    let resourceURI: URL?
    let name: String?
}
