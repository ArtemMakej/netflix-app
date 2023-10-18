//
//  SceneDelegate.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let mainAssembly = MainAssembly()
        let mainViewController = mainAssembly.assemble().wrapInNavigationController()
        
        let settingsAssembly = SettingsAssembly()
        let settingsViewController = settingsAssembly.assemble().wrapInNavigationController()
        
        let likesAssembly = LikesAssembly()
        let likesViewController = likesAssembly.assemble().wrapInNavigationController()
        
        let tabBarController = UITabBarController()
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
        
        guard let _ = (scene as? UIWindowScene) else { return }
        
        let mainTabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), tag: 1)
        mainViewController.tabBarItem = mainTabBarItem
        
        
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        tabBarController.tabBar.tintColor = .red
        
        let likesTabBarItem = UITabBarItem(title: "Любимое", image: UIImage(named: "likes"), tag: 1)
        likesViewController.tabBarItem = likesTabBarItem
        
        
        
        
        
        let settingsTabBarItem = UITabBarItem(title: "Настройки", image: UIImage(named: "settings"), tag: 1)
        settingsViewController.tabBarItem = settingsTabBarItem
        
        tabBarController.viewControllers = [
            mainViewController,
            likesViewController,
            settingsViewController
        ]
    }
}

