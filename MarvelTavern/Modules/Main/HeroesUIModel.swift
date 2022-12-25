//
//  HeroesUIModel.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import Foundation

enum HeroSection {
    case heroes
}

enum HeroItem: Hashable {
    case loading(UUID)
    case heroes(Hero)
    
    var isLoading: Bool {
        switch self {
        case .loading(_):
            return true
        default:
            return false
        }
    }
    
    static var loadingItems: [HeroItem] {
        Array(repeatingExpression: HeroItem.loading(UUID()), count: 8)
    }
}
