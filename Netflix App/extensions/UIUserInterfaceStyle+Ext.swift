//
//  UIUserInterfaceStyle+Ext.swift
//  Pods
//
//  Created by Ivan Glushko on 16.04.2024.
//

import UIKit

extension UIUserInterfaceStyle {
    
    /// Конвертируем тип из `UIKit`-а в наш тип чтобы не тащить типы `UIKit` в презентер
    /// Тогда презентер не будет зависеть от `UIKit` - что архитектурно правильно
    func toInterfaceTheme() -> InterfaceTheme {
        switch self {
        case .dark: return .dark
        default: return .light
        }
    }
    
    /// Позволяет инициализировать объект `UIUserInterfaceStyle` через объект типа `InterfaceTheme`
    init(theme: InterfaceTheme) {
        switch theme {
        case .dark: 
            self = .dark
        case .light: 
            self = .light
        }
    }
}

