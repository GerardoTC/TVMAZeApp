//
//  EpisodesDetailPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//

final class EpisodesDetailPresenter: EpisodesDetailPresenterProtocol {
    
    weak var view: EpisodesDetailViewProtocol?
    var router: EpisodesDetailRouterProtocol?
    var interactor: EpisodesDetailInteractorProtocol?
    var episodeInfo: EpisodeInfo?
    
    func viewDidLoad() {
        guard let episodeInfo = episodeInfo else { return }
        view?.updateView(with: episodeInfo)
    }
}

extension EpisodesDetailPresenter: EpisodesDetailInteractorOutputProtocol {}
