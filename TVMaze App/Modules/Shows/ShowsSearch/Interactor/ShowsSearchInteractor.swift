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
    
    init(network: BaseAPIProtocol = MazeAPI()) {
        self.network = network
    }
    
    func searchForShows(with text: String) {
        let resource = NetworkResource<[BaseShowInfoModel]>(requestInfo: MazeEndPoints.showsSearch(query: text),
                                                            parse: [BaseShowInfoModel].decode)
        network.getRequest(resource: resource) { [weak self] result in
            switch result {
            case .success(let shows):
                DispatchQueue.main.async {
                    self?.presenter?.updateShows(shows: shows)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
