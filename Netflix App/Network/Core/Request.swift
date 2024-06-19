//
//  Request.swift
//  Netflix App
//
//  Created by Ivan Glushko on 19.06.2024.
//

import Foundation

protocol IRequest {
    func toUrlRequest() -> URLRequest
}

/// Обертка над URLRequest (запросом)
struct Request: IRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]
    let body: Data?
    
    func toUrlRequest() -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = body
        
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}
