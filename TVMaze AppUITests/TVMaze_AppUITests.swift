//
//  TVMaze_AppUITests.swift
//  TVMaze AppUITests
//
//  Created by Gerardo Tarazona Caceres on 15/10/21.
//

import XCTest

class TVMaze_AppUITests: XCTestCase {

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        let tabBar = app.tabBars["Tab Bar"]
        tabBar.buttons["Favorites"].tap()
        tabBar.buttons["Settings"].tap()
    }

}
