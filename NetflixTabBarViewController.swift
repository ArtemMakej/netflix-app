//
//  SettingTabBarViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 01.06.2024.
//

import UIKit

final class NetflixTabBarViewController: UITabBarController {
    
    private let themeTintColour: UIColor.Dynamic = .tabBarColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apply(dynamicColor: themeTintColour, theme: traitCollection.userInterfaceStyle)
        configureViewControllers()
        configureTabBarAppearance()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        apply(dynamicColor: themeTintColour, theme: traitCollection.userInterfaceStyle)
    }
    
    private func configureViewControllers() {
        let mainAssembly = MainAssembly()
        let likesAssembly = LikesAssembly()
        let settingAssembly = SettingsAssembly()
        
        let mainViewController = mainAssembly.assemble().wrapInNavigationController()
        let likesViewController = likesAssembly.assemble().wrapInNavigationController()
        let settingViewController = settingAssembly.assemble().wrapInNavigationController()
        
        mainViewController.tabBarItem.image = UIImage(named: "home")
        likesViewController.tabBarItem.image = UIImage(named: "likes")
        settingViewController.tabBarItem.image = UIImage(named: "settings")
        
        mainViewController.title = "Главная"
        likesViewController.title = "Любимое"
        settingViewController.title = "Настройки"
        
        self.viewControllers = [mainViewController, likesViewController,  settingViewController]
    }
    
    private func apply(dynamicColor: UIColor.Dynamic?, theme: UIUserInterfaceStyle) {
        switch theme {
        case .dark:
            tabBar.tintColor = dynamicColor?.dark
        default:
            tabBar.tintColor = dynamicColor?.light
        }
    }
    
    private func configureTabBarAppearance() {
        let appearance = UITabBarItem.appearance() // почитать
        let attributes: [NSAttributedString.Key: Any] = [.font: Font.avenir(weight: .medium, size: 10)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
}
