//
//  DetailsViewModel.swift
//  MarvelTavern
//
//  Created by Paul Matar on 25/12/2022.
//

import Foundation
import Combine

protocol DetailsViewModelProtocol {
    var sections: CurrentValueSubject<[DetailsSection], Never> { get }
    func getDetails()
    func setTitle() ->  String
    func openWebview(_ url: URL)
}

final class DetailsViewModel: DetailsViewModelProtocol {
    private(set) var sections = CurrentValueSubject<[DetailsSection], Never>(DetailsSection.allCases)
    
    
    private let service: APIService
    private let coordinator: HeroesCoordinator
    private let transferedData: Any
    
    init(service: APIService, data: Any, _ coordinator: HeroesCoordinator) {
        self.service = service
        self.coordinator = coordinator
        transferedData = data
    }
    
    func getDetails() {
        guard let casted = transferedData as? Int else { return }

        Task { @MainActor in
            do {
                let fetchedData: [DetailsSection] = try await service.fetchDetails(by: casted)
                sections.send(fetchedData)
            } catch {
                debugPrint(error)
            }
        }
    }
    
    func setTitle() -> String {
        guard let casted = transferedData as? Int else { return "" }
        return "HERO'S ID: \(casted)"
    }
    
    func openWebview(_ url: URL) {
        coordinator.startWebview(url)
    }
}

