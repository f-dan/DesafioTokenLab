//
//  SceneDelegate.swift
//  ImdbList
//
//  Created by Danilo on 29/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var coordinator: ImdbCoordinator!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        coordinator = ImdbCoordinator()
        let navigationController = UINavigationController(rootViewController: coordinator.start())
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        coordinator.navigation = navigationController
        self.window = window
    }
}

