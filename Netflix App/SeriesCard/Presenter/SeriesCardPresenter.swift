//
//  SeriesCardPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 23.11.2023.
//

import Foundation

protocol ISeriesCardPresenter {
    func viewDidLoad()
    func viewWillAppear()
    func didTapLikeButton()
    func didTapPlayButton()
}

final class SeriesCardPresenter: ISeriesCardPresenter {
    weak var view: ISeriesCardView?
    private var netflixFullModel: NetflixFull?
    private let netflixShortModel: NetflixShortModel
    private let id: String
    private var isLiked = false
    
    init(id: String, netflixShortModel: NetflixShortModel) {
        self.id = id
        self.netflixShortModel = netflixShortModel
    }
    
    func viewDidLoad() {
        loadNetflixFull()
    }
    
    func viewWillAppear() {
        guard let id = netflixFullModel?.id else { return }
        
        if LikedTvShowsService.shared.hasLike(tvShowId: id) {
            view?.showFilledLike()
        } else {
            view?.showEmptyLike()
        }
    }
    
    func didTapLikeButton() {
        guard let show = netflixFullModel else { return }
        if LikedTvShowsService.shared.hasLike(tvShowId: id) {
            LikedTvShowsService.shared.removeLike(tvShow: show)
            view?.showEmptyLike()
        } else {
            LikedTvShowsService.shared.addLike(tvShow: show)
            view?.showFilledLike()
        }
    }
    
    func didTapPlayButton() {
        let url = netflixShortModel.url
        view?.showSafariViewController(url: url)
    }
    
    private func loadNetflixFull() {
        let urlRequst = "https://netflix-list-rust.fly.dev/netflix/show/\(id)"
        guard let url = URL(string: urlRequst) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data
            else { return }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(NetflixFull.self, from: data)
                self?.netflixFullModel = result
                DispatchQueue.main.async {
                    self?.view?.updateView(with: result)
                }
            } catch let error {
                print("Error seriliazation json", error)
            }
        }.resume()
    }
}
