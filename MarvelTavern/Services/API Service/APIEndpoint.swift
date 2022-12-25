//
//  APIEndpoint.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

enum APIEndpoint {
    case heroes
}

extension APIEndpoint: Endpoint {
    var path: String {
        switch self {
        case .heroes:
            let ts = String(Date().timeIntervalSince1970)
            let hash = (ts + privateKey + publicKey).MD5
            
            return "/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .heroes:
            return .GET
        }
    }
    
    private var privateKey: String {
        Bundle.main.infoDictionary?["PRIVATE_KEY"] as? String ?? ""
    }
    
    private var publicKey: String {
        Bundle.main.infoDictionary?["PUBLIC_KEY"] as? String ?? ""
    }
}
