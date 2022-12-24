//
//  RequestError.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

enum HTTPError: Error {
    case invalidURL
    case invalidResponse
    case invalidStatusCode(Int)
    case invalidData
    case unableToDecode
    case unknown
}

extension HTTPError: CustomStringConvertible {
    var description: String {
        switch self {
        case .invalidURL:
            return "Bad URL"
        case .invalidResponse:
            return "The server did not return 200"
        case .invalidData:
            return "Bad data returned"
        case .unableToDecode:
            return "Unable to decode JSON"
        case .unknown:
            return "Unknown error"
        case .invalidStatusCode(let code):
            return "Error - \(code)"
        }
    }
}
