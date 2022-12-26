//
//  DetailsUIModel.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import Foundation

enum DetailsSection: Hashable, CaseIterable {
    case comics([DetailsItem])
    case events([DetailsItem])
    case stories([DetailsItem])
    case series([DetailsItem])
    
    static var allCases: [DetailsSection] {
        [
            .comics(DetailsItem.loadingItems),
            .series(DetailsItem.loadingItems),
            .events(DetailsItem.loadingItems),
            .stories(DetailsItem.loadingItems),
        ]
    }
    
    var items: [DetailsItem] {
        switch self {
        case .comics(let items),
                .events(let items),
                .stories(let items),
                .series(let items):
            return items
        }
    }
    
    var title: String {
        switch self {
        case .comics:
            return C.Text.comics
        case .events:
            return C.Text.events
        case .stories:
            return C.Text.stories
        case .series:
            return C.Text.series
        }
    }
}

enum DetailsItem: Hashable {
    case loading(UUID)
    case details(Detail)
    
    static var loadingItems: [DetailsItem] {
        Array(repeatingExpression: DetailsItem.loading(UUID()), count: 3)
    }
}
