//
//  SceneDelegate.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        configureUI()
        
        let window = UIWindow(windowScene: scene)
        self.window = window
        window.overrideUserInterfaceStyle = .dark
        
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
    }

    private func configureUI() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: C.Colors.marvelRed) ?? .red,
            .font: UIFont(name: C.Fonts.marvelFont, size: 30) ?? .systemFont(ofSize: 30)
        ]
        navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
            .font: UIFont(name: C.Fonts.marvelFont, size: 22) ?? .systemFont(ofSize: 22)
        ]

        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    }
}

