//
//  UIApplication+Ext.swift
//  Netflix App
//
//  Created by Ivan Glushko on 16.04.2024.
//

import UIKit

protocol InterfaceStyleOverrider {
    // изменяет текущую тему
    func change(theme: InterfaceTheme)
    // получить
    func currentTheme() -> InterfaceTheme
}

extension UIApplication: InterfaceStyleOverrider {
    func change(theme: InterfaceTheme) {
        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = UIUserInterfaceStyle(theme: theme)
    }
    
    func currentTheme() -> InterfaceTheme {
        UIApplication.shared.keyWindow!.traitCollection.userInterfaceStyle.toInterfaceTheme()
    }
    
    
}
