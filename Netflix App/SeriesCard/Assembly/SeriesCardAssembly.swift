//
//  SeriesCardAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import UIKit

protocol ISeriesCardAssembly {
    func assemble() -> UIViewController
}

final class SeriesCardAssembly: ISeriesCardAssembly {
    func assemble() -> UIViewController {
        let presenter = SeriesCardPresenter()
        let viewcontroller = SeriesCardViewController(presenter: presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}
