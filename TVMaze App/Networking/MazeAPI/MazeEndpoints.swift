//
//  MazeEndpoints.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

enum MazeEndPoints: RequestInfo {
    var url: URL {
        var urlComponents = URLComponents()
        urlComponents.host = host
        urlComponents.scheme = scheme
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { fatalError("URL could not be constructed \(urlComponents.string ?? "url not found")")}
        return url
    }
    
    var method: HTTPMethod { .get }
    
    var path: String {
        switch self {
        case .showsSearch:
            return "/search/shows"
        case .episodes(let showId):
            return "/shows/\(showId)"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .showsSearch(let query):
            return [URLQueryItem(name: "q", value: query)]
        case .episodes:
            return [URLQueryItem(name: "embed", value: "episodes")]
        }
    }
    
    case showsSearch(query: String)
    case episodes(showId: Int)
}
