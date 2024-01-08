//
//  SeriesCardAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import UIKit

protocol ISeriesCardAssembly {
    func assemble(id: String) -> UIViewController
}

final class SeriesCardAssembly: ISeriesCardAssembly {
    func assemble(id: String) -> UIViewController {
        let presenter = SeriesCardPresenter(id: id)
        let viewcontroller = SeriesCardViewController(presenter: presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}
