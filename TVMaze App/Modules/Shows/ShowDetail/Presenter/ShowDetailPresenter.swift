//
//  ShowDetailPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

final class ShowDetailPresenter: ShowDetailPresenterProtocol {
    weak var view: ShowDetailViewProtocol?
    var router: ShowDetailRouterProtocol?
    var interactor: ShowDetailInteractorProtocol?
    var seasons: [Int: [EpisodeInfo]] = [:]
    var episodes: [EpisodeInfo] = []
    var showInfo: ShowInfoDetail?
    var showId: Int?
    
    func viewDidLoad() {
        interactor?.getShowInfo(id: showId ?? 0)
        view?.startLoading()
    }
    
    func setupFavorite() {
        let isFavorite = interactor?.isFavoriteShow(id: showId ?? 0) ?? false
        view?.updateButton(isFavorite: isFavorite)
    }
    
    func episodesCount() -> Int {
        episodes.count
    }
    
    func setup(cell: BaseEpisodeCollectionCell?, at index: Int) {
        let episodeInfo = episodes[index]
        cell?.setupWith(image: episodeInfo.poster ?? "", name: "\(index + 1). \(episodeInfo.name)")
    }
    
    func updateEpisodesWith(season: Int) {
        episodes = seasons[season + 1] ?? []
        view?.updateEpisodesList()
    }
    
    func seasonsCount() -> Int {
        seasons.count
    }
    
    func seasonTitle(for season: Int) -> String {
        "shows.detail.season".localized + "\(season + 1)"
    }
    
    func seasonSelected(_ item: Int) {
        updateEpisodesWith(season: item)
    }
    
    func didSelect(episode: Int) {
        var episode = episodes[episode]
        episode.showPoster = showInfo?.poster
        router?.routeToEpisodeDetail(episode)
    }
    
    func likebuttonPressed() {
        if interactor?.isFavoriteShow(id: showId ?? 0) ?? false {
            interactor?.removeShow(id: showId ?? 0)
            view?.updateButton(isFavorite: false)
        } else {
            interactor?.addToFavoriteShows(showInfo, showId: showId ?? 0)
            view?.updateButton(isFavorite: true)
        }
    }
}

extension ShowDetailPresenter: ShowDetailInteractorOutputProtocol {
    func updateShowInfo(info show: ShowInfoDetail, seasons: [Int : [EpisodeInfo]]) {
        self.seasons = seasons
        showInfo = show
        guard let showInfo = showInfo else { return }
        view?.updateView(showInfo)
        if seasons[1] != nil {
            updateEpisodesWith(season: 0)
        } else {
            view?.hideEpisodes()
        }
        view?.stopLoading()
        setupFavorite()
    }
    
    func handle(error: Error) {
        router?.presentAlertError(error: error)
    }
}
