//
//  Image.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

struct Image: Codable {
    let path: String?
    let _extension: String?
    
    var stringUrl: String {
        "\(path ?? "").\(_extension ?? "")".https
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case _extension = "extension"
    }
}
