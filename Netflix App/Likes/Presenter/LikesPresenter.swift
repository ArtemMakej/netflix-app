//
//  LikesPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 05.10.2023.
//

import Foundation

// MARK: - ILikesPresenter

protocol ILikesPresenter {
    func viewDidLoad()
    func viewWillAppear()
    func didTapLikeButton(atIndexPath: IndexPath)
    func numberOfCells() -> Int
    func cell(for indexPath: IndexPath) -> LikesScreenCell
}

final class LikesPresenter: ILikesPresenter {
    
    // MARK: - Properties
    
    weak var view: ILikesView?
    private var cells: [LikesScreenCell] {
        LikedTvShowsService.shared.likedTvShows().map { model in
            return LikesScreenCell.likeCell(model)
        }
    }
    
    func viewDidLoad() {}
    func viewWillAppear() {
        view?.reloadData()
    }
    
    func didTapLikeButton(atIndexPath: IndexPath) {
        switch cells[atIndexPath.item] {
        case let .likeCell(model):
            if LikedTvShowsService.shared.hasLike(tvShowId: model.id) {
                LikedTvShowsService.shared.removeLike(tvShow: model)
                view?.showEmptyLike(indexPath: atIndexPath)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: { [weak self] in
                    self?.view?.reloadData()
                })
            } else {
                LikedTvShowsService.shared.addLike(tvShow: model)
                view?.showFilledLike(indexPath: atIndexPath)
            }
        }
    }
    
    func numberOfCells() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> LikesScreenCell {
        cells[indexPath.item]
    }
}
