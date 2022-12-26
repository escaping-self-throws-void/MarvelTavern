//
//  HeroesViewModel.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import Combine

protocol HeroesViewModel {
    var heroes: CurrentValueSubject<[HeroItem], Never> { get }
    func getHeroes()
    func goToDetails(_ data: Any)
}

final class HeroesViewModelImpl: HeroesViewModel {
    private(set) var heroes = CurrentValueSubject<[HeroItem], Never>(HeroItem.loadingItems)
        
    private let coordinator: HeroesCoordinator
    private let service: APIService
    
    init(service: APIService, _ coordinator: HeroesCoordinator) {
        self.service = service
        self.coordinator = coordinator
    }
    
    func getHeroes() {
        Task { @MainActor in
            do {
                let fetchedData = try await service.fetchHeroes()
                heroes.send(fetchedData.map(HeroItem.heroes))
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func goToDetails(_ data: Any) {
        coordinator.openDetailsScreen(data)
    }
}
