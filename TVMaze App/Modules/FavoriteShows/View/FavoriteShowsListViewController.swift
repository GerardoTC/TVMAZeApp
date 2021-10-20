//
//  FavoriteShowsListViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 20/10/21.
//
import UIKit

final class FavoriteShowsListViewController: UIViewController, Storyboarded {
    
    var presenter: FavoriteShowsListPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPresenterViewLoad()
    }
    
    func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }
    
    func setupUIView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nib: ShowTableViewCell.viewID)
    }
}

extension FavoriteShowsListViewController: FavoriteShowsListViewProtocol {
    func updateShowsView() {
        tableView.reloadData()
    }
}

extension FavoriteShowsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.totalFavoriteShows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.viewID)
        presenter?.setupCell(cell as? BaseShowCell, at: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    
}

extension FavoriteShowsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectedEpisode(index: indexPath.row)
    }
}
