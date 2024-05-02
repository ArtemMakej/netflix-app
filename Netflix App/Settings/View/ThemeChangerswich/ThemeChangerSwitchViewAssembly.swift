//
//  ThemeChangerSwitchViewAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 16.04.2024.
//

import UIKit

protocol IThemeChangerSwitchViewAssembly {
    func assemble() -> ThemeChangerSwitch
}

final class ThemeChangerSwitchViewAssembly: IThemeChangerSwitchViewAssembly {
    func assemble() -> ThemeChangerSwitch {
        let presenter = ThemeChangerSwitchPresenter(interfaceStyleOverrider: UIApplication.shared)
        let view = ThemeChangerSwitch(presenter: presenter)
        presenter.view = view
        return view
    }
}
