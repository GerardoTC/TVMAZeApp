//
//  ShowDetailInteractorTest.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import XCTest
@testable import TVMaze_App

final class ShowDetailInteractorTest: XCTestCase {
    
    var mockPresenter: MockPresenter!
    var mockNetwork: NetworkingMock!
    var mockDatabase: LocalShowsDataBaseMock!
    var sut: ShowDetailInteractor!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockPresenter()
        mockNetwork = NetworkingMock()
        mockDatabase = LocalShowsDataBaseMock()
        sut = ShowDetailInteractor(network: mockNetwork,
                                   database: mockDatabase)
        sut.presenter = mockPresenter
    }
    
    override func tearDown() {
        super.tearDown()
        mockPresenter = nil
        sut = nil
    }
    
    func testgetShowInfo(){
        //GIVEN
        mockNetwork.loadJSON(response: DummyData.showResult, classForBundle: ShowDetailInteractorTest.self)
        //WHEN
        sut?.getShowInfo(id: DummyData.showId)
        //THEN
        XCTAssertEqual(mockPresenter.calledActions, [.updateShowInfo])
    }
    
    func testisFavoriteShow(){
        //GIVEN
        mockDatabase.showExistsMock = true
        //WHEN
        let result = sut?.isFavoriteShow(id: DummyData.showId)
        //THEN
        XCTAssertTrue(result ?? false)
        XCTAssertTrue(mockDatabase?.showExistsCalled ?? false)
    }
    
    func testremoveShow(){
        //WHEN
        sut?.removeShow(id: DummyData.showId)
        //THEN
        XCTAssertTrue(mockDatabase.deleteShowCalled)
    }
    
    func testaddToFavoriteShows(){
        //GIVEN
        let showInfo = DummyData.showDetail
        let showId = DummyData.showId
        //WHEN
        sut?.addToFavoriteShows(showInfo, showId: showId)
        //THEN
        XCTAssertTrue(mockDatabase.saveShowCalled)
    }
    
    
    class MockPresenter: ShowDetailInteractorOutputProtocol {
        enum MockPresenterActions {
            case updateShowInfo
            case handle
        }
        var calledActions: [MockPresenterActions] = []
        func updateShowInfo(info show: ShowInfoDetail, seasons: [Int : [EpisodeInfo]]) {
            calledActions.append(.updateShowInfo)
        }
        
        func handle(error: Error) {
            calledActions.append(.handle)
        }
    }
    
    struct DummyData {
        static let showResult = "ShowDetailResult"
        static let showDetail = ShowInfoDetail(title: "title",
                                               summary: "summary",
                                               genres: "genres",
                                               schedule: "schedule",
                                               poster: nil)
        static let showId = 12
    }
}
