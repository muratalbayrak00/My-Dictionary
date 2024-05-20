//
//  HomeViewController.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
    func setupTableView()
    func showError(_ message: String)
    func setTitle(_ title: String)
    func setRecentLabel(_ title: String)
}

final class HomeViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint! // Button'un alt boşluğunun bir constraint'ı olmalı
    
    @IBOutlet weak var recentSearchLabel: UILabel!
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        searchBar.delegate = self
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func topSearch(_ sender: UIButton) {
        
        guard let searchText = searchBar.searchTextField.text else { return }
        
        if !searchText.isEmpty {
            presenter.updateRecentWords(searchText)
        }
        
        
        reloadData()
        presenter.topSearch()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("Text Did begin edit")
        reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else { return }
        
        if !searchText.isEmpty {
            presenter.updateRecentWords(searchText)
        }
        reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else { return }
        
        if !searchText.isEmpty {
            presenter.updateRecentWords(searchText)
        }
        reloadData()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            let keyboardHeight = keyboardSize.height
            
            buttonBottomConstraint.constant = keyboardHeight - 20
            
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        buttonBottomConstraint.constant = 0
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
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
    
    func setupTableView() {
        tableView.register(cellType: RecentSearchCell.self)
    }
    
    func showError(_ message: String) {
        showAlert(title: "Error", message: message)
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    func setRecentLabel(_ title: String) {
        self.recentSearchLabel.text = title
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
        print(presenter.numberOfItems())
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: RecentSearchCell.self, for: indexPath)
        
        if let recentWord = presenter.recentWords(indexPath.row) {
            cell.cellPresenter = RecentSearchCellPresenter(view: cell, recentWord: recentWord)
        }
        
        return cell
    }
    
}
