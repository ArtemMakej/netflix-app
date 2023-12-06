//
//  SceneDelegate.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import UIKit

final class ImprovedTabBarViewController: UITabBarController {
    
    var themeTintColour: UIColor.Dynamic? {
        
        didSet {
            apply(dynamicColor: themeTintColour, theme: traitCollection.userInterfaceStyle)
        }
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(dynamicColor: themeTintColour, theme: traitCollection.userInterfaceStyle)
    }
    
    private func apply(dynamicColor: UIColor.Dynamic?, theme: UIUserInterfaceStyle) {
        switch theme {
        case .dark:
            tabBar.tintColor = dynamicColor?.dark
        default:
            tabBar.tintColor = dynamicColor?.light
        }
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let viewControllers = configureViewControllers()
        let tabBarController = setupTabBarController(with: viewControllers)
        
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = tabBarController
    }
    
    func configureViewControllers() -> [UIViewController] {
        let mainAssembly = MainAssembly()
        let settingsAssembly = SettingsAssembly()
        let likesAssembly = LikesAssembly()
        
        let mainViewController = mainAssembly.assemble().wrapInNavigationController()
        let settingsViewController = settingsAssembly.assemble().wrapInNavigationController()
        let likesViewController = likesAssembly.assemble().wrapInNavigationController()
        
        return [mainViewController, likesViewController, settingsViewController]
    }
    
    func setupTabBarController(with viewControllers: [UIViewController]) -> ImprovedTabBarViewController {
        let tabBarController = ImprovedTabBarViewController()
        tabBarController.themeTintColour = UIColor.tabBarColor
        configureTabBarAppearance()
        
        setupTabBarItems(for: viewControllers, in: tabBarController)
        return tabBarController
    }
    
    func setupTabBarItems(for viewControllers: [UIViewController], in tabBarController: UITabBarController) {
        for (index, viewController) in viewControllers.enumerated() {
            let title: String
            let imageName: String
            switch index {
            case 0:
                title = "Главная"
                imageName = "home"
            case 1:
                title = "Любимое"
                imageName = "likes"
            case 2:
                title = "Настройки"
                imageName = "settings"
            default:
                title = ""
                imageName = ""
            }
            
            let tabBarItem = createTabBarItem(title: title, imageName: imageName, tag: index)
            viewController.tabBarItem = tabBarItem
        }
        
        tabBarController.viewControllers = viewControllers
    }
    
    func createTabBarItem(title: String, imageName: String, tag: Int) -> UITabBarItem {
        return UITabBarItem(title: title, image: UIImage(named: imageName), tag: tag)
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
}
