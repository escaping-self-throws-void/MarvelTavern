//
//  Url.swift
//  MarvelTavern
//
//  Created by Paul Matar on 26/12/2022.
//

import Foundation

struct Url: Codable {
    let type: UrlType?
    let url: URL?
    
    var safeUrl: URL? {
        guard let url else { return nil }
        return URL(string: url.absoluteString.https)
    }
}

enum UrlType: String, Codable {
    case detail
    case purchase
    case reader
    case inAppLink
    case unknown
    
    init(from decoder: Decoder) throws {
        self = try UrlType(rawValue: decoder
            .singleValueContainer().decode(RawValue.self)) ?? .unknown
    }
}
