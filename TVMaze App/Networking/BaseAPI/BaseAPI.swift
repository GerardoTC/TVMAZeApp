//
//  BaseAPI.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

protocol BaseAPIProtocol: AnyObject {
    @discardableResult
    func getRequest<T>(resource: NetworkResource<T>, completion: @escaping (Result<T,Error>) -> Void) -> URLSessionTask
}
