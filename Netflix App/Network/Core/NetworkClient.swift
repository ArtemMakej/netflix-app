//
//  NetworkClient.swift
//  Netflix App
//
//  Created by Artem Mackei on 19.06.2024.
//

import Foundation
// MARK: - INetworkClient
protocol INetworkClient {
    func performJsonDataRequest<Response: Decodable>(request: IRequest) async throws -> Response
    func performDataRequest(request: IRequest) async throws -> Data 
}

final class NetworkClient: INetworkClient {
    private let session: URLSession
    private let jsonDecoder: JSONDecoder
    // MARK: - Init
    init(session: URLSession, jsonDecoder: JSONDecoder) {
        self.session = session
        self.jsonDecoder = jsonDecoder
    }
    
    func performJsonDataRequest<Response>(request: IRequest) async throws -> Response where Response : Decodable {
        let (data, _) = try await session.data(for: request.toUrlRequest())
        let decodedResult = try jsonDecoder.decode(Response.self, from: data)
        return decodedResult
    }
    
    func performDataRequest(request: IRequest) async throws -> Data {
        let (data, _) = try await session.data(for: request.toUrlRequest())
        return data
    }
}
