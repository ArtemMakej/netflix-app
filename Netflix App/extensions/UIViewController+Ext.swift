//
//  UIViewController+Ext.swift
//  Netflix App
//
//  Created by Artem Mackei on 17.10.2023.
//

import UIKit

extension UIViewController {
    
    func wrapInNavigationController() -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: self)
        return navigationController
    }
}
