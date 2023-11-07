//
//   NetflixShort.swift
//  Netflix App
//
//  Created by Artem Mackei on 03.11.2023.
//

import UIKit

struct NetflixShortModel: Decodable {
    let id: String
    let title: String
    let url: String
    let img: ImageData
    let more: String
}

struct ImageData: Decodable {
    let width: Int
    let height: Int
    let url: String
    let alt_text: String?
}
