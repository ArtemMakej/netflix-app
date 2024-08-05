//
//  MainPresenter.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.10.2023.
//

import Foundation

// MARK: - IMainPresenter

protocol IMainPresenter {
    func viewDidLoad()
    func numberOfCells() -> Int
    func cell(for indexPath: IndexPath) -> MainScreenCell
    func refreshControlDidStart()
    func userDidScrollToPageEnd()
    func didConfigureCell(_ indexPath: IndexPath)
}

final class MainPresenter: IMainPresenter {
    
    // MARK: - Properties
    
    weak var view: IMainView?
    
    private let mainQueue: DispatchQueue
    
    private let netflixService: INetflixService
    private var cells: [MainScreenCell] = []
    private var pageNumber = 1
    private var canMakeNewRequest = true
    
    
    init(netflixService: INetflixService, mainQueue: DispatchQueue) {
        self.netflixService = netflixService
        self.mainQueue = mainQueue
    }
    
    func viewDidLoad() {
        loadNetflixTvShows(page: pageNumber)
    }
    
    func cell(for indexPath: IndexPath) -> MainScreenCell {
        cells[indexPath.item]
    }
    
    func numberOfCells() -> Int {
        return cells.count
    }
    
    func refreshControlDidStart() {
        cells = []
        pageNumber = 1
        view?.reloadData()
        loadNetflixTvShows(page: pageNumber) { [weak self] _ in
            self?.view?.stopRefreshControl()
        }
    }
    
    func userDidScrollToPageEnd() {
        guard canMakeNewRequest else { return }
        pageNumber += 1
        canMakeNewRequest = false
        loadNetflixTvShows(page: pageNumber) { [weak self] _ in
            self?.canMakeNewRequest = true
        }
    }
    
    func didConfigureCell(_ indexPath: IndexPath) {
        let cell = cell(for: indexPath)
        switch cell {
        case let .tvShow(model):
            Task {
                do {
                    let data = try await netflixService.loadImage(imageURL: model.img.url)
                    await MainActor.run { [weak self] in
                        self?.view?.updateNetflixCell(imageData: data, indexPath: indexPath)
                    }
                } catch {
                    await MainActor.run { [weak self] in
                        self?.view?.updateNetflixCellWithImageStub(indexPath: indexPath)
                    }
                }
            }
        }
    }
    
    private func loadNetflixTvShows(page: Int, completion: ((Bool) -> Void)? = nil) {
        Task {
            do {
                let models = try await netflixService.getNetflix(page: page)
                let mappedModels = models.map { MainScreenCell.tvShow(model: $0) }
                self.cells.append(contentsOf: mappedModels)
                mainQueue.async { [weak self] in
                    self?.view?.removeStub()
                    self?.view?.reloadData()
                    completion?(true)
                }
            } catch {
                if cells.isEmpty {
                    mainQueue.async { [weak self] in
                        self?.view?.show(stub: .noTvShows(action: { [weak self] in
                            guard let self else { return }
                            loadNetflixTvShows(page: page, completion: completion)
                        }))
                    }
                }
            }
        }
    }
}
