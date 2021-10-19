//
//  ShowDetailInteractor.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//
import Foundation

final class ShowDetailInteractor: ShowDetailInteractorProtocol {
    weak var presenter: ShowDetailInteractorOutputProtocol?
    var network: BaseAPIProtocol
    init(network: BaseAPIProtocol = MazeAPI()) {
        self.network = network
    }
    
    func getShowInfo(id: Int) {
        
        let resource = NetworkResource<ShowDetailInfoModel>(requestInfo: MazeEndPoints.episodes(showId: id), parse: ShowDetailInfoModel.decode)
        
        network.getRequest(resource: resource) { [weak self] (result) in
            switch result {
            case .success(let showInfo):
                self?.handleSuccess(result: showInfo)
            case .failure(let error):
                self?.presenter?.handle(error: error)
            }
        }
    }
    
    func handleSuccess(result: ShowDetailInfoModel) {
        var seasonsDict: [Int : [EpisodeInfo]] = [:]
        result._embedded.episodes.forEach { (episode) in
            if seasonsDict[episode.season] == nil {
                seasonsDict[episode.season] = [EpisodeInfo(id: episode.id,
                                                           name: episode.name,
                                                           season: episode.season,
                                                           number: episode.number,
                                                           poster: episode.image?.medium ?? "",
                                                           originalPoster: episode.image?.original,
                                                           summary: episode.summary ?? "")]
            } else {
                seasonsDict[episode.season]?.append(EpisodeInfo(id: episode.id,
                                                                name: episode.name,
                                                                season: episode.season,
                                                                number: episode.number,
                                                                poster: episode.image?.medium ?? "",
                                                                originalPoster: episode.image?.original,
                                                                summary: episode.summary ?? ""))
            }
        }
        presenter?.updateShowInfo(info: ShowInfoDetail(title: result.name,
                                                       summary: result.summary,
                                                       genres: result.genres.joined(separator: ", "),
                                                       schedule: [ result.schedule.days.joined(separator: ","), "\(result.schedule.time)"].joined(separator: " • "),
                                                       poster: result.image?.original),
                                  seasons: seasonsDict)
    }
}
