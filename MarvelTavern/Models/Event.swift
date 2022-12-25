//
//  File.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct EventList: Codable {
    let returned: Int?
    let items: [Event]?
}

struct Event: Codable {
    let resourceURI: URL?
    let name: String?
}
