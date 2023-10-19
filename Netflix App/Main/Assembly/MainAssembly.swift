//
//  MainAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 04.10.2023.
//

import UIKit

protocol IMainAssembly {
    func assemble() -> UIViewController
}

final class MainAssembly: IMainAssembly {
    func assemble() -> UIViewController {
        let presenter = MainPresenter()
        let viewcontroller = MainViewController(presenter:presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}
