//
//  MainPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import Foundation

protocol IMainPresenter {
    func viewDidLoad()
}

final class MainPresenter: IMainPresenter {
    
    weak var view: IMainView?
    
    func viewDidLoad() {
    }
}
