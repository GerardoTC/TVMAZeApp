//
//  ShowDetailRouter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

import UIKit

final class ShowDetailRouter: ShowDetailRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createShowDetailModule(id: Int) -> ShowDetailViewController? {
        let ref = ShowDetailViewController.create(from: .showDetail)
        
        let presenter: ShowDetailPresenterProtocol & ShowDetailInteractorOutputProtocol = ShowDetailPresenter()
        
        let router = ShowDetailRouter()
        router.viewController = ref
        
        let interactor = ShowDetailInteractor()
        interactor.presenter = presenter
        
        presenter.view = ref
        presenter.router = router
        presenter.interactor = interactor
        presenter.showId = id
        
        ref?.presenter = presenter
        return ref
    }
    
    func routeToEpisodeDetail(_ episode: EpisodeInfo) {
        guard let vc = EpisodesDetailRouter.createEpisodesDetailModule(episode) else { return }
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}

