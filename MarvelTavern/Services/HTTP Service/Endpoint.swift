//
//  Endpoint.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var baseURL: String {
        "https://\(Bundle.main.infoDictionary?["BASE_URL"] ?? "")"
    }
    
    var header: [String: String]? {
        nil
    }
    
    var body: [String: Any]? {
        nil
    }
}

enum RequestMethod: String {
    case DELETE
    case GET
    case PATCH
    case POST
    case PUT
}
