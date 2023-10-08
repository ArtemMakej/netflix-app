//
//  SettingsViewController.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import UIKit

protocol ISettingsView: AnyObject {
    
}

class SettingsViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    private let presenter: ISettingsPresenter
    
    init(presenter: ISettingsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsViewController: ISettingsView {
    
}
