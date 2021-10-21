//
//  ShowsSearchInteractor.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//
import Foundation

final class ShowsSearchInteractor: ShowsSearchInteractorProtocol {
    weak var presenter: ShowsSearchInteractorOutputProtocol?
    var network: BaseAPIProtocol
    var currentPage = 0
    let lastPage = 234
    
    init(network: BaseAPIProtocol = MazeAPI()) {
        self.network = network
    }
    
    func searchForShows(with text: String) {
        let resource = NetworkResource<[BaseShowInfoModel]>(requestInfo: MazeEndPoints.showsSearch(query: text),
                                                            parse: [BaseShowInfoModel].decode)
        network.getRequest(resource: resource) { [weak self] result in
            switch result {
            case .success(let shows):
                self?.presenter?.updateShowsSearch(shows: shows)
            case .failure(let error):
                self?.presenter?.handle(error: error)
            }
        }
    }
    
    func showList(for page: Int) {
        guard page != currentPage || page == 0 else { return }
        guard page < lastPage else {
            presenter?.limitPageReached()
            return
        }
        currentPage = page
        let resource = NetworkResource<[ShowInfoModel]>(requestInfo: MazeEndPoints.showsList(page: page),
                                                        parse: [ShowInfoModel].decode)
        network.getRequest(resource: resource) { [weak self] result in
            switch result {
            case .success(let shows):
                self?.presenter?.updateShowsList(shows: shows.map {
                    BaseShowInfoModel(score: nil, show: $0)
                })
            case .failure(let error):
                self?.presenter?.handle(error: error)
            }
        }
    }
}
