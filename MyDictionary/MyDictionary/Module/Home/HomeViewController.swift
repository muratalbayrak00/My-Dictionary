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
    func hideClearButton()
    func showClearButton()
}

final class HomeViewController: BaseViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint! // Button'un alt boşluğunun bir constraint'ı olmalı
    
    @IBOutlet weak var recentSearchLabel: UILabel!
    
    @IBOutlet weak var clearButton: UIButton!
    
    @IBAction func clearRecentSearch(_ sender: Any) {
        presenter.clearRecentSearchs()
        reloadData()
    }
    
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
        // When click the searh button, clear search bar text.
        searchBar.searchTextField.text?.removeAll()
        
        reloadData()
        presenter.topSearch(searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else { return }
        
        if !searchText.isEmpty {
            presenter.updateRecentWords(searchText)
        }
        // When click the searh button, clear search bar text.
        reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.searchTextField.text else { return }
        
        if !searchText.isEmpty {
            presenter.updateRecentWords(searchText)
        }
        // When click the searh button, clear search bar text.
        searchBar.searchTextField.text?.removeAll()
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
    
    func hideClearButton() {
        clearButton.isHidden = true
    }
    
    func showClearButton() {
        clearButton.isHidden = false
    }
    
}

extension HomeViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: burayi yap
    }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
