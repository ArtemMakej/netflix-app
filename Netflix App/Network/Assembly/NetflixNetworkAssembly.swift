//
//  NetflixNetworkAssembly.swift
//  Netflix App
//
//  Created by Artem Mackei on 19.06.2024.
//

import Foundation

// MARK: - INetflixNetworkAssembly

protocol INetflixNetworkAssembly {
    func assembleNetflixService() -> INetflixService
}

final class NetflixNetworkAssembly: INetflixNetworkAssembly {
    
    // MARK: - Properties
    
    private let baseURL = URL(string: "https://netflix-list-rust.fly.dev")!
    private let jsonEncoder = JSONEncoder()
    private lazy var jsonDecoder = assembleJsonDecoder()
    private lazy var requestBuilder = RequestBuilder(jsonEncoder: jsonEncoder)
    private lazy var networkClient = NetworkClient(session: .shared, jsonDecoder: jsonDecoder)
    
    func assembleNetflixService() -> INetflixService {
        NetflixService(
            networkClient: networkClient,
            requestBuilder: requestBuilder,
            baseUrl: baseURL
        )
    }
    
    private func assembleJsonDecoder() -> JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        return jsonDecoder
    }
}
