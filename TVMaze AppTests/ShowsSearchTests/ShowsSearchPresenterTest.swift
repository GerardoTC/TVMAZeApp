//
//  ShowsSearchPresenterTest.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import XCTest
@testable import TVMaze_App

final class ShowsSearchPresenterTest: XCTestCase {
    
    private var mockView: MockView!
    private var mockRouter: MockRouter!
    private var mockInteractor: MockInteractor!
    private var sut: ShowsSearchPresenter!
    private var mockDebouncer: DebouncerTextMock!
    
    override func setUp() {
        super.setUp()
        mockDebouncer = DebouncerTextMock()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = ShowsSearchPresenter(debouncer: mockDebouncer)
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        sut = nil
    }
    
    func testViewDidLoad() {
        //WHEN
        sut?.viewDidLoad()
        //THEN
        XCTAssertNotNil(sut?.debouncer.closure)
        XCTAssertEqual(mockInteractor?.calledActions, [.showList])
        XCTAssertEqual(mockView?.calledActions, [.showLoadingFooter])
    }
    
    func testDidEndEditing() {
        //WHEN
        sut?.didEndEditing(text: DummyData.searchText)
        //THEN
        XCTAssertEqual(mockInteractor?.calledActions, [.searchForShows])
    }
    
    func testSearchDidChange() {
        //WHEN
        sut?.searchDidChange(DummyData.searchText)
        //THEN
        XCTAssertTrue(mockDebouncer.restarIntervalCalled)
    }
    
    func testRegisterDebouncer() {
        //GIVEN
        sut?.viewDidLoad()
        //WHEN
        mockDebouncer.closure?(DummyData.searchText)
        //THEN
        XCTAssertEqual(mockInteractor?.calledActions, [.showList, .searchForShows])
    }
    
    func testGetRowsCountForShowList() {
        //GIVEN
        sut?.showsList = DummyData.showListInfo
        //WHEN
        let rowsCount = sut?.getRowsCount(isShowList: true)
        //THEN
        XCTAssertEqual(rowsCount, 1)
    }
    
    func testGetRowsCountForSearch() {
        //GIVEN
        sut?.showsSearch = DummyData.showListInfo
        //WHEN
        let rowsCount = sut?.getRowsCount(isShowList: false)
        //THEN
        XCTAssertEqual(rowsCount, 1)
    }
    
    func testSetupCellShowList() {
        //GIVEN
        let cell = DummyData.baseRowShow
        sut?.showsList = DummyData.showListInfo
        //WHEN
        sut?.setup(cell: cell, at: 0, isShowList: true)
        //THEN
        XCTAssertTrue(cell.setupWasCalled)
        XCTAssertEqual(mockInteractor.calledActions, [.showList])
        XCTAssertEqual(mockView.calledActions, [.showLoadingFooter])
    }
    
    func testSetupCellSearch() {
        //GIVEN
        let cell = DummyData.baseRowShow
        sut?.showsSearch = DummyData.showListInfo
        //WHEN
        sut?.setup(cell: cell, at: 0, isShowList: false)
        //THEN
        XCTAssertTrue(cell.setupWasCalled)
    }
    
    func testShowListShowSelected() {
        //GIVEN
        sut?.showsList = DummyData.showListInfo
        //WHEN
        sut?.showSelected(0, isShowList: true)
        //THEN
        XCTAssertEqual(mockRouter.calledActions, [.routeToDetail])
    }
    
    func testShowSearchShowSelected() {
        //GIVEN
        sut?.showsSearch = DummyData.showListInfo
        //WHEN
        sut?.showSelected(0, isShowList: false)
        //THEN
        XCTAssertEqual(mockRouter.calledActions, [.routeToDetail])
    }
    
    func testUpdateShowsList() {
        //WHEN
        sut?.updateShowsList(shows: DummyData.showListInfo)
        //THEN
        XCTAssertEqual(sut?.page, 1)
        XCTAssertEqual(mockView.calledActions, [.hideLoadingFooter, .refreshShowsListView])
        XCTAssertEqual(sut?.showsList.count, 1)
    }
    
    func testUpdateShowSearch() {
        //WHEN
        sut?.updateShowsSearch(shows: DummyData.showListInfo)
        //THEN
        XCTAssertEqual(mockView.calledActions, [.refreshShowsSearchView])
        XCTAssertEqual(sut?.showsSearch.count, 1)
    }
    
    func testLimitPageReached() {
        //WHEN
        sut?.limitPageReached()
        //THEN
        XCTAssertEqual(mockView.calledActions, [.hideLoadingFooter])
    }
    
    func testHandleErro() {
        //WHEN
        sut?.handle(error: NetworkError.connectionError)
        //THEN
        XCTAssertEqual(mockRouter.calledActions, [.presentAlertError])
    }
    
    struct DummyData {
        static let searchText = "Django"
        static let showListInfo = [BaseShowInfoModel(score: 0.4, show: ShowInfoModel(id: 11,
                                                                                     name: "Name Show",
                                                                                     summary: nil,
                                                                                     image: nil))]
        static let baseRowShow = BaseShowCellMock()
    }
}


private class MockView: ShowsSearchViewProtocol {
    enum MockViewActions {
        case refreshShowsSearchView
        case refreshShowsListView
        case showLoadingFooter
        case hideLoadingFooter
    }
    var calledActions: [MockViewActions] = []
    var presenter: ShowsSearchPresenterProtocol?
    
    func refreshShowsSearchView() {
        calledActions.append(.refreshShowsSearchView)
    }
    
    func refreshShowsListView() {
        calledActions.append(.refreshShowsListView)
    }
    
    func showLoadingFooter() {
        calledActions.append(.showLoadingFooter)
    }
    
    func hideLoadingFooter() {
        calledActions.append(.hideLoadingFooter)
    }
    
    
}

private class MockRouter: ShowsSearchRouterProtocol {
    var viewController: UIViewController?
    enum MockRouterActions {
        case routeToDetail
        case presentAlertError
    }
    var calledActions: [MockRouterActions] = []
    static func createShowsSearchModule() -> ShowsSearchViewController? {
        return ShowsSearchViewController()
    }
    
    func routeToDetail(id: Int) {
        calledActions.append(.routeToDetail)
    }
    
    func presentAlertError(error: Error) {
        calledActions.append(.presentAlertError)
    }
}

private class MockInteractor: ShowsSearchInteractorProtocol {
    var presenter: ShowsSearchInteractorOutputProtocol?
    
    enum MockInteractorActions {
        case searchForShows
        case showList
    }
    var calledActions: [MockInteractorActions] = []
    
    func searchForShows(with: String) {
        calledActions.append(.searchForShows)
    }
    
    func showList(for page: Int) {
        calledActions.append(.showList)
    }
}
