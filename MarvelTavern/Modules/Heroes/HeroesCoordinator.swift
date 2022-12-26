//
//  HeroesCoordinator.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class HeroesCoordinator: BaseCoordinator {
            
    override func start() {
        let viewModel = HeroesViewModelImpl(service: APIServiceImpl(), self)
        let viewController = HeroesViewController(viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
    
    func startDetailsScreen(_ data: Any) {
        let viewModel = DetailsViewModelImpl(service: APIServiceImpl(), data: data, self)
        let viewController = DetailsViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func startWebview(_ url: URL) {
        let viewController = WebViewController(url: url)
        navigationController.pushViewController(viewController, animated: true)
    }
}
