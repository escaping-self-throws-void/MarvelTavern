//
//  HeroesCoordinator.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class HeroesCoordinator: BaseCoordinator {
            
    override func start() {
        let viewModel = HeroesViewModelImpl(service: APIServiceImpl())
        let viewController = HeroesViewController(viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
