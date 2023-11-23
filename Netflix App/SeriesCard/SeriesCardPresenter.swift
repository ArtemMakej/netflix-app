//
//  SeriesCardPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import Foundation

protocol ISeriesCardPresenter {
    func viewDidLoad()
    func setUp(with tvShowModel: TvShowModel)
}

final class SeriesCardPresenter: ISeriesCardPresenter {
    weak var view: ISeriesCardView?


    func viewDidLoad() {
    }


    func setUp(with tvShowModel: TvShowModel) {
        }
}
