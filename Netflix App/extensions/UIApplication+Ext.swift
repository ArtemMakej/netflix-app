//
//  UIApplication+Ext.swift
//  Netflix App
//
//  Created by Ivan Glushko on 16.04.2024.
//

import UIKit

/// Подписываем `UIApplication` под протокол, чтобы
/// передать в дальнейшем в презентер
extension UIApplication: InterfaceStyleOverrider {
    
    /// Меняем тему
    func change(theme: InterfaceTheme) {
        self.keyWindow!.overrideUserInterfaceStyle = UIUserInterfaceStyle(theme: theme)
    }
    
    /// Получаем текущую тему интерфейса
    func currentTheme() -> InterfaceTheme {
        self.keyWindow!.traitCollection.userInterfaceStyle.toInterfaceTheme()
    }
}
