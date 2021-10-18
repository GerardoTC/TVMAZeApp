//
//  EpisodesDetailRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//

import UIKit

final class EpisodesDetailRouter: EpisodesDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createEpisodesDetailModule(_ episodeInfo: EpisodeInfo) -> EpisodesDetailViewController? {
        let ref = EpisodesDetailViewController.create(from: .episodesDetail)
        
        let presenter: EpisodesDetailPresenterProtocol & EpisodesDetailInteractorOutputProtocol = EpisodesDetailPresenter()
        
        let router = EpisodesDetailRouter()
        router.viewController = ref
        
        let interactor = EpisodesDetailInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        presenter.episodeInfo = episodeInfo
        
        ref?.presenter = presenter
        return ref
    }
}

