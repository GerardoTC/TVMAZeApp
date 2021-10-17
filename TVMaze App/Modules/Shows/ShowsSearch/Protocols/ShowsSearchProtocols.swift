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
}

protocol ShowsSearchPresenterProtocol: AnyObject {
    var view: ShowsSearchViewProtocol? { get set }
    var router: ShowsSearchRouterProtocol? { get set }
    var interactor: ShowsSearchInteractorProtocol? { get set }
    
    func searchDidChange(_ text: String)
    func getTotalRows() -> Int
    func setup(cell: BaseShowCell?, at position: Int)
    func viewDidLoad()
    func showSelected(_ row: Int)
}

protocol ShowsSearchInteractorOutputProtocol: AnyObject {
    func updateShows(shows: [BaseShowInfoModel])
}

protocol ShowsSearchRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createShowsSearchModule() -> ShowsSearchViewController?
    func routeToDetail(id: Int)
}

protocol ShowsSearchViewProtocol: AnyObject {
    var presenter: ShowsSearchPresenterProtocol? { get set }
    func refreshShowsView()
}
