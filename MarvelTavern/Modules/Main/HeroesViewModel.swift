//
//  HeroesViewModel.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Foundation
import Combine

protocol HeroesViewModel {
    var refresh: PassthroughSubject<Bool, Never> { get }
    var heroes: [Hero] { get }
    
    func getHeroes()
}

final class HeroesViewModelImpl: HeroesViewModel {
    private(set) var refresh = PassthroughSubject<Bool, Never>()
    private(set) var heroes = [Hero]()
    
    private let service: APIService
    
    init(service: APIService) {
        self.service = service
    }
    
    func getHeroes() {
        Task {
            do {
                let fetchedData = try await service.fetchHeroes()
                heroes = fetchedData
                refresh.send(true)
            } catch {
                debugPrint(error)
            }
        }
    }
    
//    private func mapModels(_ data: [ArtistsItem]) {
//        artists = data.map { ArtistModel(with: $0) }
//    }
}
