//
//  MainPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import Foundation
import UIKit

protocol IMainPresenter {
    func viewDidLoad()
    func numberOfCells() -> Int
    func cell(for indexPath: IndexPath) -> MainScreenCell
    func refreshControlDidStart()
    func userDidScrollToPageEnd()
}

final class MainPresenter: IMainPresenter {
    
    weak var view: IMainView?
    private var cells: [MainScreenCell] = []
    private var pageNumber = 1
    private var canMakeNewRequest = true
    
    func viewDidLoad() {
        loadingNetflixList(page: pageNumber)
    }
    
    func cell(for indexPath: IndexPath) -> MainScreenCell {
        return cells[indexPath.item]
    }
    
    func numberOfCells() -> Int {
        return cells.count
    }
    
    func refreshControlDidStart() {
        cells = []
        pageNumber = 1
        view?.reloadData()
        loadingNetflixList(page: pageNumber) { [weak self] isOk in
            self?.view?.stopRefreshControl()
        }
    }
    
    func userDidScrollToPageEnd() {
        guard canMakeNewRequest else { return }
        pageNumber += 1
        canMakeNewRequest = false
        loadingNetflixList(page: pageNumber) { [weak self] _ in
            self?.canMakeNewRequest = true
        }
    }
    
    private func loadingNetflixList(page: Int, completion: ((Bool) -> Void)? = nil) {
        let urlRequst = "https://netflix-list-rust.fly.dev/netflix/shows?page=\(page)"
        guard let url = URL(string: urlRequst) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data
            else { return }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode([NetflixShortModel].self, from: data)
                let mappedResult = result.map { MainScreenCell.tvShow(model: $0) }
                self.cells.append(contentsOf: mappedResult)
                DispatchQueue.main.async {
                    self.view?.reloadData()
                    completion?(true)
                }
            } catch let error {
                print("Error serialization json", error)
                completion?(false)
            }
        }.resume()



    }

}
