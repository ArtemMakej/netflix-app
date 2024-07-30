//
//  RequestBuilder.swift
//  Netflix App
//
//  Created by Artem Mackei on 19.06.2024.
//

import Foundation
// MARK: - IRequestBuilder
protocol IRequestBuilder {
    func buildGetRequest(url: URL, headers: [String: String], queryItems: [URLQueryItem]) -> IRequest
    func buildPostRequest<T: Encodable>(url: URL, headers: [String: String], data: T) throws -> IRequest
}

final class RequestBuilder: IRequestBuilder {
    private let jsonEncoder: JSONEncoder
    // MARK: - Init
    init(jsonEncoder:JSONEncoder) {
        self.jsonEncoder = jsonEncoder
    }
    
    func buildGetRequest(url: URL, headers: [String : String], queryItems: [URLQueryItem]) -> IRequest {
        var url = url
        url.append(queryItems: queryItems)
        return Request(url: url, method: .GET, headers: headers, body: nil)
    }
    
    func buildPostRequest<T>(url: URL, headers: [String : String], data: T) throws -> IRequest where T: Encodable {
        let body = try jsonEncoder.encode(data)
        return Request(url: url, method: .POST, headers: headers, body: body)
    }
}
