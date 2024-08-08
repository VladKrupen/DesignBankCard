//
//  SceneDelegate.swift
//  BankCard
//
//  Created by Vlad on 7.08.24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewController()
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
    }
}

