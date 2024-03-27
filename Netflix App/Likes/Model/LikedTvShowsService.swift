//
//  LikedTvShowsService.swift
//  Netflix App
//
//  Created by Artem Mackei on 15.02.2024.
//

import Foundation

protocol ILikedTvShowsService {
    // все лайки
    func likedTvShows() -> [NetflixFull]
    // добавляем
    func addLike(tvShow: NetflixFull)
    // удаляем
    func removeLike(tvShow: NetflixFull)
    // проверяем есть ли лайк на вью
    func hasLike(tvShowId: String) -> Bool
}

final class LikedTvShowsService: ILikedTvShowsService {
    
    static let shared = LikedTvShowsService()
    
    private static let likedTvShowsKey = "likedTvShows"
    
    private var shows: [NetflixFull] = []
    
    private init() {
     // получаем сохраненнные данные data (данные UserDefaults) по ключу
        guard let showsObject = UserDefaults.standard.object(forKey: LikedTvShowsService.likedTvShowsKey) as? Data else { return }
    // дату преобразовываем в массив [NetflixFull] с помощью метода decode
        guard let showsToStorage = try? JSONDecoder().decode([NetflixFull].self, from: showsObject)
        else {
            return
        }
        // присваиваем новое значение массиву shows от showsToStorage
        shows = showsToStorage
    }
    
    func likedTvShows() -> [NetflixFull] {
        return shows
    }
    
    func addLike(tvShow: NetflixFull) {
        guard !shows.contains(where: { item in //логическое отрицание shows - false
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
        // превращаем массив shows в Data
        let data = try! JSONEncoder().encode(shows)
        defaults.set(data, forKey: LikedTvShowsService.likedTvShowsKey)
     }
}
