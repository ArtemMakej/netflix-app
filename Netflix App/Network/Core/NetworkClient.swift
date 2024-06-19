//
//  NetworkClient.swift
//  Netflix App
//
//  Created by Ivan Glushko on 19.06.2024.
//

import Foundation

protocol INetworkClient {
    func performJsonDataRequest<Response: Decodable>(request: IRequest) async throws -> Response
}

final class NetworkClient: INetworkClient {
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(session: URLSession, jsonDecoder: JSONDecoder) {
        self.session = session
        self.jsonDecoder = jsonDecoder
    }
    
    func performJsonDataRequest<Response: Decodable>(request: IRequest) async throws -> Response {
        let (data, _) = try await session.data(for: request.toUrlRequest())
        let decodedResult = try jsonDecoder.decode(Response.self, from: data)
        return decodedResult
    }
}
