//
//  SceneDelegate.swift
//  Crypto2
//
//  Created by Victor on 02.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, 
			   willConnectTo session: UISceneSession,
			   options connectionOptions: UIScene.ConnectionOptions) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = HomeViewAssembly.configure()
		window?.makeKeyAndVisible()
	}
}
