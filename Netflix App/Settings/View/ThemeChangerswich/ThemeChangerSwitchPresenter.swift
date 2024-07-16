//
//  ThemeChangerSwitchPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 14.04.2024.
//

import Foundation

enum HorizontalPosition {
    case left
    case right
}

protocol IThemeChangerSwitchPresenter {
    
    func switchMovedTo(position: HorizontalPosition)
    func viewLayotSubviews()
}

final class ThemeChangerSwitchPresenter: IThemeChangerSwitchPresenter {
    // MARK: - Properties
    weak var view: IThemeChangerSwitchView?
    private let interfaceStyleOverrider: InterfaceStyleOverrider
    // MARK: - Init
    init(interfaceStyleOverrider: InterfaceStyleOverrider) {
        self.interfaceStyleOverrider = interfaceStyleOverrider
    }
    
    func switchMovedTo(position: HorizontalPosition) {
        interfaceStyleOverrider.change(theme: position == .left ? .light : .dark)
    }
    
    func viewLayotSubviews() {
        let currentTheme = interfaceStyleOverrider.currentTheme()
        let position: HorizontalPosition = currentTheme == .light ? .left : .right
        view?.set(position: position)
    }
}
