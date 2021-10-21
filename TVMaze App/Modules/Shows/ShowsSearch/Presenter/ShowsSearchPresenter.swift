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
    var showsSearch: [BaseShowInfoModel] = []
    var showsList: [BaseShowInfoModel] = []
    var debouncer: TextDebouncerProtocol
    var page = 0
    
    init(debouncer: TextDebouncerProtocol = TextDebouncer(timeInterval: 0.5)) {
        self.debouncer = debouncer
    }
    
    private func registerDebouncer() {
        debouncer.closure =  { [weak self] text in
            guard let self = self,
                  let text = text else {
                return
            }
            self.didEndEditing(text: text)
        }
    }
    
    func viewDidLoad() {
        registerDebouncer()
        interactor?.showList(for: page)
        view?.showLoadingFooter()
    }
    
    func didEndEditing(text: String) {
        interactor?.searchForShows(with: text)
    }
    
    func searchDidChange(_ text: String) {
        debouncer.restarInterval(with: text)
    }
    
    func getRowsCount(isShowList: Bool) -> Int {
        isShowList ? showsList.count : showsSearch.count
    }
    
    func setup(cell: BaseShowCell?, at position: Int, isShowList: Bool) {
        cell?.setupWith(model: isShowList ? showsList[position] : showsSearch[position])
        if isShowList, position == showsList.count - 1 {
            interactor?.showList(for: page)
            view?.showLoadingFooter()
        }
    }
    
    func showSelected(_ row: Int, isShowList: Bool) {
        router?.routeToDetail(id: isShowList ? showsList[row].show.id : showsSearch[row].show.id)
    }
}

extension ShowsSearchPresenter: ShowsSearchInteractorOutputProtocol {
    func updateShowsList(shows: [BaseShowInfoModel]) {
        page += 1
        showsList.append(contentsOf: shows)
        view?.hideLoadingFooter()
        view?.refreshShowsListView()
    }
    
    func updateShowsSearch(shows: [BaseShowInfoModel]) {
        showsSearch = shows
        view?.refreshShowsSearchView()
    }
    
    func limitPageReached() {
        view?.hideLoadingFooter()
    }
    
    func handle(error: Error) {
        router?.presentAlertError(error: error)
    }
}
