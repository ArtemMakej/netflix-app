//
//  NetflixFull.swift
//  Netflix App
//
//  Created by Artem Mackei on 11.12.2023.
//

import UIKit

struct NetflixFull: Codable {
    let id: String
    let full_image_url: String
    let title: String
    let duration: String
    let presented_at_date: String
    let rating: NetflixRating
    let description: String
    let actors: [String]
    let country: [String]
    let in_lists: [String]
    let genre: [String]
}

struct NetflixRating: Codable {
    let imbd: String
    let kinopoisk: String
}
