//
//  MainCoordinator.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
            
    override func start() {
        let viewModel = MainViewModelImpl()
        let viewController = MainViewController(viewModel)
        navigationController.setViewControllers([viewController], animated: false)
    }
}
