//
//  ThemeChangerSwitchViewAssembly.swift
//  Netflix App
//
//  Created by Ivan Glushko on 16.04.2024.
//

import UIKit

protocol IThemeChangerSwitchViewAssembly {
    
    /// Собирает switch view
    func assemble() -> ThemeChangerSwitch
}

final class ThemeChangerSwitchViewAssembly: IThemeChangerSwitchViewAssembly {
    
    /// Настройка и создание свитча
    ///
    /// Подобно модулю
    func assemble() -> ThemeChangerSwitch {
        let presenter = ThemeChangerSwitchPresenter(interfaceStyleOverrider: UIApplication.shared)
        let view = ThemeChangerSwitch(presenter: presenter)
        presenter.view = view
        return view
    }
}
