//
//  LikesAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 05.10.2023.
//

import UIKit

protocol ILikesAssembly {
    func assemble() -> UIViewController
}


class LikesAssembly {
    func assemble() -> UIViewController {
        let presenter = LikesPresenter()
        let viewcontroller = LikesViewController(presenter: presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}


extension LikesAssembly: ILikesAssembly {
}
