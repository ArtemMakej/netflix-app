//
//  UIUserInterfaceStyle+Ext.swift
//  Pods
//
//  Created by Ivan Glushko on 16.04.2024.
//

import UIKit

enum InterfaceTheme {
    case light
    case dark
}

extension UIUserInterfaceStyle {
    
    func toInterfaceTheme() -> InterfaceTheme {
        switch self {
        case .dark: return .dark
        default: return .light
        }
    }
    // MARK: - Init
    init(theme: InterfaceTheme) {
        switch theme {
        case .dark: 
            self = .dark
        case .light: 
            self = .light
        }
    }
}
