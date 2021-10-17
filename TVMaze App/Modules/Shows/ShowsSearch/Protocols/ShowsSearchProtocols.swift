//
//  ShowsSearchProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//
import UIKit

protocol ShowsSearchInteractorProtocol: AnyObject {
    var presenter: ShowsSearchInteractorOutputProtocol? { get set }
    func searchForShows(with: String)
    func showList(for page: Int)
}

protocol ShowsSearchPresenterProtocol: AnyObject {
    var view: ShowsSearchViewProtocol? { get set }
    var router: ShowsSearchRouterProtocol? { get set }
    var interactor: ShowsSearchInteractorProtocol? { get set }
    
    func searchDidChange(_ text: String)
    func getTotalSearchRows(isShowList: Bool) -> Int
    func setup(cell: BaseShowCell?, at position: Int, isShowList: Bool)
    func viewDidLoad()
    func showSearchedSelected(_ row: Int, isShowList: Bool)
}

protocol ShowsSearchInteractorOutputProtocol: AnyObject {
    func updateShowsSearch(shows: [BaseShowInfoModel])
    func updateShowsList(shows: [BaseShowInfoModel])
    func limitPageReached()
}

protocol ShowsSearchRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createShowsSearchModule() -> ShowsSearchViewController?
    func routeToDetail(id: Int)
}

protocol ShowsSearchViewProtocol: AnyObject {
    var presenter: ShowsSearchPresenterProtocol? { get set }
    func refreshShowsSearchView()
    func refreshShowsListView()
    func showLoadingFooter()
    func hideLoadingFooter()
}
