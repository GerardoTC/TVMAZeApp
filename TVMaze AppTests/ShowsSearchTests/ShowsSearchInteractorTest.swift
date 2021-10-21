//
//  ShowsSearchInteractorTest.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import XCTest
@testable import TVMaze_App

final class ShowsSearchInteractorTest: XCTestCase {
    
    private var mockPresenter: MockPresenter!
    var sut: ShowsSearchInteractor!
    var network: NetworkingMock!
    
    override func setUp() {
        super.setUp()
        network = NetworkingMock()
        mockPresenter = MockPresenter()
        sut = ShowsSearchInteractor(network: network)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        sut = nil
        network = nil
    }
    
    func testShowsList() {
        //GIVEN
        network.loadJSON(response: DummyData.listOfShows, classForBundle: ShowsSearchInteractorTest.self)
        //WHEN
        sut.showList(for: 0)
        //THEN
        XCTAssertTrue(mockPresenter.calledActions == [.updateShowsList])
    }
    
    func testShowsListLimitPage() {
        //WHEN
        sut.showList(for: 235)
        //THEN
        XCTAssertTrue(mockPresenter.calledActions == [.limitPageReached])
    }
    
    func testShowsListFailure() {
        //WHEN
        sut.showList(for: 10)
        //THEN
        XCTAssertTrue(mockPresenter.calledActions == [.handleError])
    }
    
    func testSearchShow() {
        //GIVEN
        network.loadJSON(response: DummyData.searchResult, classForBundle: ShowsSearchInteractorTest.self)
        //WHEN
        sut.searchForShows(with: DummyData.searchText)
        //THEN
        XCTAssertTrue(mockPresenter.calledActions == [.updateShowsSearch])
    }
    
    func testSearchShowFailure() {
        //WHEN
        sut.searchForShows(with: DummyData.searchText)
        //THEN
        XCTAssertTrue(mockPresenter.calledActions == [.handleError])
    }
    
    struct DummyData {
        static let listOfShows = "ListOfShowsResult"
        static let searchResult = "SearchShowResult"
        static let searchText = "Squid game"
    }
}

private class MockPresenter: ShowsSearchInteractorOutputProtocol {
    enum MockPresenterActions {
        case updateShowsSearch
        case updateShowsList
        case limitPageReached
        case handleError
    }
    
    var calledActions: [MockPresenterActions] = []
    
    func updateShowsSearch(shows: [BaseShowInfoModel]) {
        calledActions.append(.updateShowsSearch)
    }
    
    func updateShowsList(shows: [BaseShowInfoModel]) {
        calledActions.append(.updateShowsList)
    }
    
    func limitPageReached() {
        calledActions.append(.limitPageReached)
    }
    
    func handle(error: Error) {
        calledActions.append(.handleError)
    }
}
