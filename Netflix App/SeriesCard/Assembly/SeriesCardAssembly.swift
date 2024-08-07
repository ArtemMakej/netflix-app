//
//  SeriesCardAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import UIKit

// MARK: - ISeriesCardAssembly

protocol ISeriesCardAssembly {
    func assemble(id: String, netflixShortModel: NetflixShortModel) -> UIViewController
}

final class SeriesCardAssembly: ISeriesCardAssembly {
    
    func assemble(id: String, netflixShortModel: NetflixShortModel) -> UIViewController {
        let presenter = SeriesCardPresenter(id: id, netflixShortModel: netflixShortModel)
        let viewcontroller = SeriesCardViewController(presenter: presenter)
        presenter.view = viewcontroller
        return viewcontroller
    }
}
