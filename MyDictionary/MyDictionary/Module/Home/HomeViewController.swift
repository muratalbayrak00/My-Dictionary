//
//  HomeViewController.swift
//  MyDictionary
//
//  Created by murat albayrak on 18.05.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupSearchController()
    func setupTableView()
    func showError(_ message: String)
    func setTitle(_ title: String)
}

final class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()

    }

}

extension HomeViewController: HomeViewControllerProtocol {

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupSearchController() {
        searchController.searchBar.placeholder = "Search Word"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: RecentSearchCell.self)
    }
    
    func showError(_ message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: burayi yap
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(indexPath.row)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: RecentSearchCell.self, for: indexPath)
        
        if let recentWords = presenter.recentWords(indexPath.row) {
            cell.cellPresenter = RecentSearchCellPresenter(view: cell, recentWords: recentWords)
        }
        
        return cell
    }
    
}
