//
//  ViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 15/10/21.
//

import UIKit

final class ShowsSearchViewController: UIViewController, Storyboarded {
    
    var presenter: ShowsSearchPresenterProtocol?
    var darkMode = false
    lazy var showsTableView: UITableView = UITableView()
    lazy var footerLoader: UIActivityIndicatorView = UIActivityIndicatorView(frame: .zero)
    @IBOutlet weak var showsListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
        presenter?.viewDidLoad()
    }
    
    private func setupUIView() {
        setupBackgroundColor()
        setupShowsTableView()
        setupSearchController()
    }
    
    private func setupBackgroundColor() {
        view.backgroundColor = BaseColorPalette.bgColor.color
        showsTableView.backgroundColor = BaseColorPalette.bgColor.color
    }
    
    private func setupShowsTableView() {
        showsTableView.delegate = self
        showsTableView.dataSource = self
        showsTableView.register(nib: ShowTableViewCell.viewID)
        showsTableView.separatorStyle = .none
        
        showsListTableView.register(nib: ShowTableViewCell.viewID)
        showsListTableView.delegate = self
        showsListTableView.dataSource = self
        footerLoader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        showsListTableView.tableFooterView = footerLoader
    }
    
    private func setupSearchTableView(_ vc: UIViewController) {
        showsTableView.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(showsTableView)
        NSLayoutConstraint.activate([
            showsTableView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            showsTableView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            showsTableView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            showsTableView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor)
        ])
    }
    
    private func setupSearchController() {
        let vc = UIViewController()
        setupSearchTableView(vc)
        let search = UISearchController(searchResultsController: vc)
        
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "shows.search.search_text".localized
        search.searchBar.largeContentTitle = "shows.search.title".localized
        search.searchBar.tintColor = BaseColorPalette.tintColor.color
        navigationItem.searchController = search
        navigationItem.searchController?.view.backgroundColor = BaseColorPalette.bgColor.color
    }
    
    func showLoadingFooter() {
        DispatchQueue.main.async {
            self.footerLoader.startAnimating()
            self.showsListTableView.tableFooterView?.isHidden = false
        }
    }
    
    func hideLoadingFooter() {
        DispatchQueue.main.async {
            self.footerLoader.stopAnimating()
            self.showsListTableView.tableFooterView?.isHidden = true
        }
    }
}
// MARK: - ViewProtocol
extension ShowsSearchViewController: ShowsSearchViewProtocol {
    func refreshShowsSearchView() {
        DispatchQueue.main.async {
            self.showsTableView.reloadData()
        }
    }
    
    func refreshShowsListView() {
        DispatchQueue.main.async {
            self.showsListTableView.reloadData()
        }
    }
}

// MARK: - TableViewDelegate
extension ShowsSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.showSelected(indexPath.row, isShowList: tableView == showsListTableView)
    }
}

// MARK: - TableViewDataSource
extension ShowsSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.getRowsCount(isShowList: tableView == showsListTableView) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.viewID, for: indexPath)
        presenter?.setup(cell: tableCell as? BaseShowCell, at: indexPath.row, isShowList: tableView == showsListTableView)
        return tableCell
    }
}

// MARK: - SearchResultsUpdating
extension ShowsSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text != "" else { return }
        presenter?.searchDidChange(text)
    }
}
