//
//  SeriesCardPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import Foundation

protocol ISeriesCardPresenter {
    func viewDidLoad()
}

final class SeriesCardPresenter: ISeriesCardPresenter {
    weak var view: ISeriesCardView?
    private let id: String
    
    init(id: String) {
        self.id = id
    }

    func viewDidLoad() {
        loadNetflixFull()
    }

    private func loadNetflixFull() {
        let urlRequst = "https://netflix-list-rust.fly.dev/netflix/show/\(id)"
        guard let url = URL(string: urlRequst) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data
            else { return }
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(NetflixFull.self, from: data)
                DispatchQueue.main.async {
                    self.view?.updateView(with: result)
                }
            } catch let error {
                print("Error seriliazation json", error)
            }
        }.resume()
    }
}
