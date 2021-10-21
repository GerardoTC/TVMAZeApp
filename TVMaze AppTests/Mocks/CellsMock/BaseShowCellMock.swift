//
//  BaseShowCellMock.swift
//  TVMaze AppTests
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

@testable import TVMaze_App
import UIKit

class BaseShowCellMock: UITableViewCell, BaseShowCell {
    var setupWasCalled = false
    func setupWith(model: BaseShowInfoModel) {
        setupWasCalled = true
    }
}
