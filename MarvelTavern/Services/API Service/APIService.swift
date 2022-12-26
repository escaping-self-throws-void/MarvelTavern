//
//  APIService.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation

protocol APIService {
    func fetchHeroes() async throws -> [Hero]
    func fetchHeroes(by name: String) async throws -> [Hero]
    func fetchDetails(by id: Int) async throws -> [DetailsSection]
}

struct APIServiceImpl: HTTPClient, APIService {
    func fetchHeroes() async throws -> [Hero] {
        let data: HeroDataWrapper = try await sendRequest(endpoint: APIEndpoint.heroes)

        return data.data?.results ?? []
    }
    
    func fetchHeroes(by name: String) async throws -> [Hero] {
        let data: HeroDataWrapper = try await sendRequest(endpoint: APIEndpoint.heroesBy(name: name))
                
        return data.data?.results ?? []
    }
    
    func fetchDetails(by id: Int) async throws -> [DetailsSection] {
        return try await DetailsSection.allCases.asyncMap { section in
            switch section {
            case .comics:
                let comicsData: DetailDataWrapper = try await sendRequest(endpoint: APIEndpoint.comics(id: id))
                let comics = comicsData.data?.results?.prefix(3) ?? []
                let comicsItems = Array(comics).map(DetailsItem.details)
                return DetailsSection.comics(comicsItems)
            case .events:
                let eventsData: DetailDataWrapper = try await sendRequest(endpoint: APIEndpoint.events(id: id))
                let events = eventsData.data?.results?.prefix(3) ?? []
                let eventsItems = Array(events).map(DetailsItem.details)
                return DetailsSection.events(eventsItems)
            case .stories:
                let seriesData: DetailDataWrapper = try await sendRequest(endpoint: APIEndpoint.stories(id: id))
                let series = seriesData.data?.results?.prefix(3) ?? []
                let seriesItems = Array(series).map(DetailsItem.details)
                return DetailsSection.stories(seriesItems)
            case .series:
                let storiesData: DetailDataWrapper = try await sendRequest(endpoint: APIEndpoint.series(id: id))
                let stories = storiesData.data?.results?.prefix(3) ?? []
                let storiesItems = Array(stories).map(DetailsItem.details)
                return DetailsSection.series(storiesItems)
            }
        }
    }
}

