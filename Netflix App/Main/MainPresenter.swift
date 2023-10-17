//
//  MainPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import Foundation

protocol IMainPresenter {
    func viewDidLoad()
    func numberOfCells() -> Int
    func cell(for indexPath: IndexPath) -> MainScreenCell
}

final class MainPresenter: IMainPresenter {
    
    private var cells: [MainScreenCell] = []
    weak var view: IMainView?
    
    func viewDidLoad() {
        fillCells()
    }
    
    func fillCells() {
        cells = [.tvShow(model: TvShowModel(name: "Lost"))]
    }
    
    func cell(for indexPath: IndexPath) -> MainScreenCell {
        return cells[indexPath.item]
    }
    
    func numberOfCells() -> Int {
        return cells.count
    }
}
