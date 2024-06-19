//
//  RequestBuilder.swift
//  Netflix App
//
//  Created by Ivan Glushko on 19.06.2024.
//

import Foundation

/// Собирает сетевой запрос
protocol IRequestBuilder {
    func buildGetRequest(url: URL, headers: [String : String], queryItems: [URLQueryItem]) -> IRequest
    func buildPostRequest<T: Encodable>(url: URL, headers: [String : String], data: T) throws -> IRequest
}

final class RequestBuilder: IRequestBuilder {
    private let jsonEncoder: JSONEncoder
    
    init(jsonEncoder: JSONEncoder) {
        self.jsonEncoder = jsonEncoder
    }
    
    /// GET
    func buildGetRequest(url: URL, headers: [String : String], queryItems: [URLQueryItem]) -> IRequest {
        var url = url
        url.append(queryItems: queryItems)
        return Request(url: url, method: .GET, headers: headers, body: nil)
    }
    
    /// POST
    func buildPostRequest<T: Encodable>(url: URL, headers: [String : String], data: T) throws -> IRequest {
        let body = try jsonEncoder.encode(data)
        return Request(url: url, method: .POST, headers: headers, body: body)
    }
}
