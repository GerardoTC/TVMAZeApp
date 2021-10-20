//
//  FavoriteShowsListProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//
import UIKit

protocol FavoriteShowsListInteractorProtocol: AnyObject {
    var presenter: FavoriteShowsListInteractorOutputProtocol? { get set }
    func getAllFavoriteShows() -> [ShowInfoModel]
    func deleteShow(id: Int)
}

protocol FavoriteShowsListPresenterProtocol: AnyObject {
    var view: FavoriteShowsListViewProtocol? { get set }
    var router: FavoriteShowsListRouterProtocol? { get set }
    var interactor: FavoriteShowsListInteractorProtocol? { get set }
    
    func viewDidLoad()
    func setupCell(_ cell: BaseShowCell?, at index: Int)
    func deleteFavoriteShowAt(index: Int)
    func totalFavoriteShows() -> Int
    func selectedEpisode(index: Int)
}

protocol FavoriteShowsListInteractorOutputProtocol: AnyObject {
}

protocol FavoriteShowsListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createFavoriteShowsListModule() -> FavoriteShowsListViewController?
    func routeToDetail(id: Int)
}

protocol FavoriteShowsListViewProtocol: AnyObject {
    var presenter: FavoriteShowsListPresenterProtocol? { get set }
    func updateShowsView()
}
