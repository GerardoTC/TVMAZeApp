//
//  BaseAPIConfig.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

public typealias HTTPHeaders = [String: String]

struct NetworkResource<T> {
    let requestInfo: RequestInfo
    let parse: (Data) throws -> T
}

extension NetworkResource {
    var request: URLRequest {
        var urlRequest = URLRequest(url: requestInfo.url)
        urlRequest.allHTTPHeaderFields = requestInfo.headers
        urlRequest.httpMethod = requestInfo.method.rawValue
        return urlRequest
    }
}

protocol RequestInfo {
    var url: URL { get }
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: HTTPMethod  { get }
    var headers: HTTPHeaders { get }
}

extension RequestInfo {
    var host: String { "api.tvmaze.com" }
    var scheme: String { "https"}
    var headers: HTTPHeaders { ["Content-Type": "application/json"]}
}
