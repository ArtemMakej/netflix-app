//
//  SettingsAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import UIKit
// MARK: - ISettingsAssembly
protocol ISettingsAssembly {
    func assemble() -> UIViewController
}

final class SettingsAssembly: ISettingsAssembly {
    
    func assemble() -> UIViewController {
        let presenter = SettingsPresenter()
        let viewcontroller = SettingsViewController(presenter: presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}
