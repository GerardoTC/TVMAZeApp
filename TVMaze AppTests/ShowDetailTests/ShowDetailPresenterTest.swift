//
//  ShowDetailPresenterTest.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//

import XCTest
@testable import TVMaze_App

final class ShowDetailPresenterTest: XCTestCase {
    
    private var mockView: MockView!
    private var mockRouter: MockRouter!
    private var mockInteractor: MockInteractor!
    var sut: ShowDetailPresenter!
    
    override func setUp() {
        super.setUp()
        mockView = MockView()
        mockRouter = MockRouter()
        mockInteractor = MockInteractor()
        sut = ShowDetailPresenter()
        sut.view = mockView
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    func testviewDidLoad() {
        //WHEN
        sut?.viewDidLoad()
        //THEN
        XCTAssertEqual(mockInteractor.calledActions, [.getShowInfo])
        XCTAssertEqual(mockView.calledActions, [.startLoading])
    }
    
    func testsetupFavorite() {
        //WHEN
        sut?.setupFavorite()
        //THEN
        XCTAssertEqual(mockInteractor.calledActions, [.isFavoriteShow])
        XCTAssertEqual(mockView.calledActions, [.updateButton])
    }
    
    func testepisodesCount() {
        //GIVEN
        sut?.episodes = DummyData.episodes
        //WHEN
        let count = sut?.episodesCount()
        //THEN
        XCTAssertEqual(count, 2)
    }
    
    func testsetup() {
        //GIVEN
        sut?.episodes = DummyData.episodes
        let mockCell = BaseEpisodeCollectionCellMock()
        //WHEN
        sut?.setup(cell: mockCell, at: 0)
        //THEN
        XCTAssertTrue(mockCell.setupWithCalled)
    }
    
    func testupdateEpisodesWith() {
        //GIVEN
        sut?.seasons = DummyData.seasons
        //WHEN
        sut?.updateEpisodesWith(season: 0)
        //THEN
        XCTAssertEqual(mockView.calledActions, [.updateEpisodesList])
    }
    
    func testseasonsCount() {
        //GIVEN
        sut?.seasons = DummyData.seasons
        //WHEN
        let count = sut?.seasonsCount()
        //THEN
        XCTAssertEqual(count, 1)
    }
    
    func testseasonTitle() {
        //GIVEN
        sut?.seasons = DummyData.seasons
        //WHEN
        let title = sut?.seasonTitle(for: 1)
        //THEN
        XCTAssertEqual(title, "Season 2")
    }
    
    func testseasonSelected() {
        //GIVEN
        sut?.seasons = DummyData.seasons
        //WHEN
        sut?.seasonSelected(0)
        //THEN
        XCTAssertEqual(mockView.calledActions, [.updateEpisodesList])
    }
    
    func testdidSelect() {
        //GIVEN
        sut?.episodes = DummyData.episodes
        //WHEN
        sut?.didSelect(episode: 0)
        //THEN
        XCTAssertEqual(mockRouter.calledActions, [.routeToEpisodeDetail])
    }
    
    func testlikebuttonPressed() {
        //WHEN
        sut?.likebuttonPressed()
        //THEN
        XCTAssertEqual(mockInteractor.calledActions, [.isFavoriteShow, .addToFavoriteShows])
        XCTAssertEqual(mockView.calledActions, [.updateButton])
    }
    
    func testupdateShowInfo() {
        //WHEN
        sut?.updateShowInfo(info: DummyData.showInfo, seasons: DummyData.seasons)
        
        //THEN
        XCTAssertEqual(mockView.calledActions, [.updateView, .updateEpisodesList, .stopLoading, .updateButton])
        XCTAssertEqual(mockInteractor.calledActions, [.isFavoriteShow])
    }
    
    func testhandle() {
        //WHEN
        sut?.handle(error: NetworkError.connectionError)
        //THEN
        XCTAssertEqual(mockRouter.calledActions, [.presentAlertError])
    }
    
    
    
    override func tearDown() {
        super.tearDown()
        mockView = nil
        mockRouter = nil
        mockInteractor = nil
        sut = nil
    }
    
    struct DummyData {
        static let episodes = [EpisodeInfo(id: 1,
                                           name: "name",
                                           season: 1,
                                           number: 1,
                                           poster: nil,
                                           originalPoster: nil,
                                           showPoster: nil,
                                           summary: "summary"),
                               EpisodeInfo(id: 3,
                                           name: "name 2",
                                           season: 1,
                                           number: 2,
                                           poster: nil,
                                           originalPoster: nil,
                                           showPoster: nil,
                                           summary: "summary 2")]
        static let seasons = [1: episodes]
        static let showInfo =  ShowInfoDetail(title: "title",
                                              summary: "summary",
                                              genres: "Genres",
                                              schedule: "Tuesdays",
                                              poster: nil)
    }
}

private class MockView: ShowDetailViewProtocol {
    enum MockViewActions {
        case updateView
        case updateEpisodesList
        case hideEpisodes
        case startLoading
        case stopLoading
        case updateButton
    }
    var calledActions: [MockViewActions] = []
    
    func updateView(_ info: ShowInfoDetail) {
        calledActions.append(.updateView)
    }
    
    func updateEpisodesList() {
        calledActions.append(.updateEpisodesList)
    }
    
    func hideEpisodes() {
        calledActions.append(.hideEpisodes)
    }
    
    func startLoading() {
        calledActions.append(.startLoading)
    }
    
    func stopLoading() {
        calledActions.append(.stopLoading)
    }
    
    func updateButton(isFavorite: Bool) {
        calledActions.append(.updateButton)
    }
    
    var presenter: ShowDetailPresenterProtocol?
}

private class MockRouter: ShowDetailRouterProtocol {
    var viewController: UIViewController?

    enum MockRouterActions {
        case routeToEpisodeDetail
        case presentAlertError
    }
    var calledActions: [MockRouterActions] = []
    
    static func createShowDetailModule(id: Int) -> ShowDetailViewController? {
        return ShowDetailViewController()
    }
    
    func routeToEpisodeDetail(_ episode: EpisodeInfo) {
        calledActions.append(.routeToEpisodeDetail)
    }
    
    func presentAlertError(error: Error) {
        calledActions.append(.presentAlertError)
    }
}

private class MockInteractor: ShowDetailInteractorProtocol {
    
    enum MockInteractorActions {
        case getShowInfo
        case isFavoriteShow
        case removeShow
        case addToFavoriteShows
    }
    
    var calledActions: [MockInteractorActions] = []
    var isFavoriteShow = false
    
    func getShowInfo(id: Int) {
        calledActions.append(.getShowInfo)
    }
    
    func isFavoriteShow(id: Int) -> Bool {
        calledActions.append(.isFavoriteShow)
        return isFavoriteShow
    }
    
    func removeShow(id: Int) {
        calledActions.append(.removeShow)
    }
    
    func addToFavoriteShows(_ showInfo: ShowInfoDetail?, showId: Int) {
        calledActions.append(.addToFavoriteShows)
    }
    
    var presenter: ShowDetailInteractorOutputProtocol?
}
