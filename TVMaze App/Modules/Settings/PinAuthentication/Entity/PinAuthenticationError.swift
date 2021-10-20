//
//  PinAuthenticationError.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 19/10/21.
//

import Foundation

enum PinAuthenticationError: Error {
    case invalidPin
    case invalidReenterPin
}
