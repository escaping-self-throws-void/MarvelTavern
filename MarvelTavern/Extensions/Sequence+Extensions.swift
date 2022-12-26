//
//  Sequence+Extensions.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import Foundation

extension Sequence {
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()
        
        for element in self {
            try await values.append(transform(element))
        }
        
        return values
    }
}
