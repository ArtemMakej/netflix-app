//
//  SettingsPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import Foundation

protocol ISettingsPresenter {
    func viewDidLoad()
}

final class SettingsPresenter: ISettingsPresenter {
    
    weak var view: ISettingsView?
    
    func viewDidLoad() {
    }
    
}
