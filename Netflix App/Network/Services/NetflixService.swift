//
//  NetflixService.swift
//  Netflix App
//
//  Created by Artem Mackei on 19.06.2024.
//

import Foundation

protocol INetflixService {
    func getNetflix(page: Int) async throws -> [NetflixShortModel]
    func getNetflixFull() async throws -> NetflixFull
    func loadImage(imageURL: String) async throws -> Data
}

enum NetflixError: Error {
    case failedToCreatedUrl
}

struct NetflixService: INetflixService {
    // MARK: - Properties
    private let networkClient: INetworkClient
    private let requestBuilder: IRequestBuilder
    private let baseUrl: URL
    // MARK: - Init
    init(networkClient: INetworkClient, requestBuilder: IRequestBuilder, baseUrl: URL) {
        self.networkClient = networkClient
        self.requestBuilder = requestBuilder
        self.baseUrl = baseUrl
    }
    
    func getNetflixFull() async throws -> NetflixFull {
        fatalError()
    }
    
    func getNetflix(page: Int) async throws -> [NetflixShortModel] {
        let path = "netflix/shows"
        let url = baseUrl.appending(path: path)
        let query = URLQueryItem(name: "page", value: String(page))
        let request = requestBuilder.buildGetRequest(url: url, headers: [:], queryItems: [query])
        return try await networkClient.performJsonDataRequest(request: request)
    }
    
    func loadImage(imageURL: String) async throws -> Data {
        guard let url = URL(string: imageURL) else {
            throw NetflixError.failedToCreatedUrl
        }
        let request = requestBuilder.buildGetRequest(url: url, headers: [:], queryItems: [])
        return try await networkClient.performDataRequest(request: request)
    }
}
