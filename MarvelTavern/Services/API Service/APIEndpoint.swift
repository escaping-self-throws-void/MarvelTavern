//
//  APIEndpoint.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

enum APIEndpoint {
    case heroes
    case comics(id: Int)
    case events(id: Int)
    case series(id: Int)
    case stories(id: Int)
}

extension APIEndpoint: Endpoint {
    var path: String {
        switch self {
        case .heroes:
            return "/characters\(authPath)"
        case .comics(id: let id):
            return "/characters/\(id)/comics\(authPath)"
        case .events(id: let id):
            return "/characters/\(id)/events\(authPath)"
        case .series(id: let id):
            return "/characters/\(id)/series\(authPath)"
        case .stories(id: let id):
            return "/characters/\(id)/stories\(authPath)"
        }
    }
    
    var method: RequestMethod {
        .GET
    }
    
    private var authPath: String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = (ts + privateKey + publicKey).MD5
        return "?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
    }
    
    private var privateKey: String {
        Bundle.main.infoDictionary?["PRIVATE_KEY"] as? String ?? ""
    }
    
    private var publicKey: String {
        Bundle.main.infoDictionary?["PUBLIC_KEY"] as? String ?? ""
    }
}
