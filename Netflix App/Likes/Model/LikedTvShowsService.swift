//
//  LikedTvShowsService.swift
//  Netflix App
//
//  Created by Artem Mackei on 15.02.2024.
//

import Foundation

protocol ILikedTvShowsService {
    func likedTvShows() -> [NetflixFull]
    func addLike(tvShow: NetflixFull)
    func removeLike(tvShow: NetflixFull)
    func hasLike(tvShowId: String) -> Bool
}

final class LikedTvShowsService: ILikedTvShowsService {
    // MARK: - Properties
    static let shared = LikedTvShowsService()
    private static let likedTvShowsKey = "likedTvShows"
    private var shows: [NetflixFull] = []
    // MARK: - Init
    private init() {
        guard let showsObject = UserDefaults.standard.object(forKey: LikedTvShowsService.likedTvShowsKey) as? Data else { return }
        guard let showsToStorage = try? JSONDecoder().decode([NetflixFull].self, from: showsObject)
        else {
            return
        }
        shows = showsToStorage
    }
    
    func likedTvShows() -> [NetflixFull] {
        return shows
    }
    
    func addLike(tvShow: NetflixFull) {
        guard !shows.contains(where: { item in
            item.id == tvShow.id
        }) else { return }
        shows.append(tvShow)
        notifyAboutLikesChanges()
        saveToUserDefaults()
    }
    
    func removeLike(tvShow: NetflixFull) {
        for (index, show) in shows.enumerated() {
            if show.id == tvShow.id {
                shows.remove(at: index)
                notifyAboutLikesChanges()
                saveToUserDefaults()
            }
        }
    }
    
    func hasLike(tvShowId: String) -> Bool {
        var result = false
        shows.forEach { show in
            if show.id == tvShowId {
                result = true
            }
        }
        return result
    }
    
    private func notifyAboutLikesChanges() {
        NotificationCenter.default.post(name: .likePressed, object: nil)
    }
    
    private func saveToUserDefaults() {
        let defaults = UserDefaults.standard
        let data = try! JSONEncoder().encode(shows)
        defaults.set(data, forKey: LikedTvShowsService.likedTvShowsKey)
    }
}
