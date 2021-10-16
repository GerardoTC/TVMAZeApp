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
    var showsTableView: UITableView! = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
        setupUIView()
    }
    
    private func loadPresenterViewLoad() {
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
    }
    
    private func setupSearchController() {
        let vc = UIViewController()
        showsTableView.translatesAutoresizingMaskIntoConstraints = false
        vc.view.addSubview(showsTableView)
        NSLayoutConstraint.activate([
            showsTableView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            showsTableView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
            showsTableView.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor),
            showsTableView.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor)
        ])
        let search = UISearchController(searchResultsController: vc)
        
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "shows.search.search_text".localized
        search.searchBar.largeContentTitle = "shows.search.title".localized
        navigationItem.searchController = search
        navigationItem.searchController?.view.backgroundColor = BaseColorPalette.clearColor.color
    }
    
}
// MARK: - ViewProtocol
extension ShowsSearchViewController: ShowsSearchViewProtocol {}

// MARK: - TableViewDelegate
extension ShowsSearchViewController: UITableViewDelegate {}

// MARK: - TableViewDataSource
extension ShowsSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell()
        tableCell.textLabel?.setFont(.bodyM)
        tableCell.textLabel?.text = "Hello world \(indexPath.row)"
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ShowsSearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
    
}
