//
//  LikesPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 05.10.2023.
//

import Foundation

protocol ILikesPresenter {
    func viewDidLoad()
}

final class LikesPresenter: ILikesPresenter {
    
    weak var view: ILikesView?
    
    func viewDidLoad() {
    }
}
