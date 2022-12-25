//
//  AppCoordinator.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class AppCoordinator: BaseCoordinator {
     
    private let window: UIWindow
        
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let coordinator = HeroesCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator)
    }
}
