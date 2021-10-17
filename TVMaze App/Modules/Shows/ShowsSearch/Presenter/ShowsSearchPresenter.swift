//
//  ShowsSearchPresenter.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//

final class ShowsSearchPresenter: ShowsSearchPresenterProtocol {
    
    weak var view: ShowsSearchViewProtocol?
    var router: ShowsSearchRouterProtocol?
    var interactor: ShowsSearchInteractorProtocol?
    var shows: [BaseShowInfoModel] = []
    let debouncer: TextDebouncer = TextDebouncer(timeInterval: 0.5)
    
    func viewDidLoad() {
        debouncer.closure =  { [weak self] text in
            guard let self = self,
                  let text = text else {
                return
            }
            self.didEndEditing(text: text)
        }
    }
    
    func didEndEditing(text: String) {
        interactor?.searchForShows(with: text)
    }
    func searchDidChange(_ text: String) {
        debouncer.restarInterval(with: text)
    }
    
    func getTotalRows() -> Int {
        shows.count
    }
    
    func setup(cell: BaseShowCell?, at position: Int) {
        cell?.setupWith(model: shows[position])
    }
}

extension ShowsSearchPresenter: ShowsSearchInteractorOutputProtocol {
    func updateShows(shows: [BaseShowInfoModel]) {
        self.shows = shows
        view?.refreshShowsView()
    }
}
