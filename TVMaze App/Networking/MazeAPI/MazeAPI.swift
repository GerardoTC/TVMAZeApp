//
//  MazeAPI.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

class MazeAPI: BaseAPIProtocol {
    @discardableResult
    func getRequest<T>(resource: NetworkResource<T>, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask {
        let datatask = URLSession.shared.dataTask(with: resource.request) { (data, response, error) in
            completion(
                Result { [weak self] in
                    if error != nil, let response = response as? HTTPURLResponse {
                        try self?.handleError(response)
                    }
                    guard let data = data else {
                        throw NetworkError.dataNotFound
                    }
                    
                    let parseResult = try resource.parse(data)
                    return parseResult
                }
            )
        }
        datatask.resume()
        return datatask
    }
    
    func handleError(_ response: HTTPURLResponse) throws {
        if (500...599).contains(response.statusCode) {
            throw NetworkError.serverError(code: response.statusCode)
        } else {
            throw NetworkError.connectionError
        }
    }
}
