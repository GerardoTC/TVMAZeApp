//
//  ShowDetailProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//
import UIKit

protocol ShowDetailInteractorProtocol: AnyObject {
    var presenter: ShowDetailInteractorOutputProtocol? { get set }
    func getShowInfo(id: Int)
}

protocol ShowDetailPresenterProtocol: AnyObject {
    var view: ShowDetailViewProtocol? { get set }
    var router: ShowDetailRouterProtocol? { get set }
    var interactor: ShowDetailInteractorProtocol? { get set }
    var showId: Int? { get set }
    
    func viewDidLoad()
    func episodesCount() -> Int
    func setup(cell: BaseEpisodeCollectionCell?, at index: Int)
    func seasonsCount() -> Int
    func seasonTitle(for: Int) -> String
    func seasonSelected(_ item: Int)
}

protocol ShowDetailInteractorOutputProtocol: AnyObject {
    func updateShowInfo(info show: ShowInfoDetail, seasons: [Int : [EpisodeInfo]])
}

protocol ShowDetailRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createShowDetailModule(id: Int) -> ShowDetailViewController?
}

protocol ShowDetailViewProtocol: AnyObject {
    var presenter: ShowDetailPresenterProtocol? { get set }
    func updateView(_ info: ShowInfoDetail)
    func updateEpisodesList()
    func hideEpisodes()
}
