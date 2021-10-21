//
//  NetworkingMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import XCTest
@testable import TVMaze_App

class NetworkingMock: BaseAPIProtocol {
    var mockData: Data? = nil
    var mockStatusCode: Int? = nil
    @discardableResult
    func getRequest<T>(resource: NetworkResource<T>, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionTask? {
            completion(
                Result { [weak self] in
                    
                    if let statuscode = self?.mockStatusCode {
                        throw NetworkError.serverError(code: statuscode)
                    }
                    guard let data = self?.mockData else {
                        throw NetworkError.dataNotFound
                    }
                    
                    let parseResult = try resource.parse(data)
                    return parseResult
                }
            )
        return nil
    }
    
    func loadJSON(response: String, classForBundle: AnyClass) {
        guard let jsonPath = Bundle(for: classForBundle).url(forResource: response, withExtension: "json") else {
            XCTFail("JSON response Not found: \(response).json")
            return
        }
        
        mockData = try? Data(contentsOf: jsonPath)
    }
}
