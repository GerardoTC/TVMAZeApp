//
//  EpisodesDetailProtocols.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//
import UIKit

protocol EpisodesDetailInteractorProtocol: AnyObject {
    var presenter: EpisodesDetailInteractorOutputProtocol? { get set }
}

protocol EpisodesDetailPresenterProtocol: AnyObject {
    var view: EpisodesDetailViewProtocol? { get set }
    var router: EpisodesDetailRouterProtocol? { get set }
    var interactor: EpisodesDetailInteractorProtocol? { get set }
    var episodeInfo: EpisodeInfo? { get set }
    
    func viewDidLoad()
}

protocol EpisodesDetailInteractorOutputProtocol: AnyObject {
}

protocol EpisodesDetailRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    
    static func createEpisodesDetailModule(_ episodeInfo: EpisodeInfo) -> EpisodesDetailViewController?
}

protocol EpisodesDetailViewProtocol: AnyObject {
    var presenter: EpisodesDetailPresenterProtocol? { get set }
    func updateView(with info: EpisodeInfo)
}
