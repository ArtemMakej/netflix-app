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
        loadingNetflixList()
    }
    
    func cell(for indexPath: IndexPath) -> MainScreenCell {
        return cells[indexPath.item]
    }
    
    func numberOfCells() -> Int {
        return cells.count
    }
    
    private func loadingNetflixList() {
        let urlRequst = "https://netflix-list-rust.fly.dev/netflix/shows?page=1"
        guard let url = URL(string: urlRequst) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data
            else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([NetflixShortModel].self, from: data)
                self.cells = result.map { .tvShow(model: $0) }
                DispatchQueue.main.async {
                    self.view?.reloadData()
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }.resume()
        
    }
}
