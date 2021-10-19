//
//  BasePresenterWithError.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 18/10/21.
//

import Foundation
protocol BasePresenterWithError: AnyObject {
    func handle(error: Error)
}
