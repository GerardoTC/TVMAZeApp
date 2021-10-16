//
//  NetworkError.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case dataNotFound
    case unableToParse(model: String)
    case connectionError
    case serverError(code: Int)
    
    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "No data Found"
        case .unableToParse(let model):
            return "Unable to Parse data to \(model)"
        case .connectionError:
            return "Internet Connection Error"
        case .serverError(let code):
            return "Server is not available: ErrorCode: \(code)"
        }
    }
}
