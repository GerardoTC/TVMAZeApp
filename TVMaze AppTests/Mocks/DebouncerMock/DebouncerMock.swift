//
//  DebouncerMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import Foundation
@testable import TVMaze_App

class DebouncerTextMock: TextDebouncerProtocol {
    var closure: ClosureHandler?
    var restarIntervalCalled: Bool = false
    
    func restarInterval(with text: String) {
        restarIntervalCalled = true
    }
}
