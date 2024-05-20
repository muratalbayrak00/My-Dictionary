//
//  HomePresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation
import DictionaryApi

protocol HomePresenterProtocol {
    func viewDidLoad()
    func numberOfItems() -> Int
    func recentWords(_ index: Int) -> String?
    func topSearch(_ searchText: String)
    func updateRecentWords(_ text: String)
    func clearRecentSearchs()
}

final class HomePresenter {
    
    unowned var view: HomeViewControllerProtocol!
    let router: HomeRouterProtocol!
    let interactor: HomeInteractorProtocol!
    
    private var recentSearchs: [String] = []
    
    
    init(view: HomeViewControllerProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension HomePresenter: HomePresenterProtocol {

    func updateRecentWords(_ text: String) {
        if !recentSearchs.contains(text){
            self.recentSearchs.append(text)
            
            UserDefaults.standard.set(recentSearchs, forKey: "RecentSearches")
        }
    }
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("Search Word")
        view.setRecentLabel("Recent Search")
        getRecentWordsOutput()
        setRecentSearchs()
    }
    
    func numberOfItems() -> Int {
        return recentSearchs.count
    }
    
    func recentWords(_ index: Int) -> String? {
        return recentSearchs[index] // TODO: Burayi gereksiz olabilir tekrar bak.
    }
    
    private func getRecentSearchs() -> [String] {
        // TODO: Show loading
        return self.recentSearchs
       // interactor.getRecentSearchs()
    }
    
    func topSearch(_ searchText: String) {
        router.navigate(.details(searchText: searchText))
    }
    
    func setRecentSearchs() {
        if let savedRecentSearchs = UserDefaults.standard.array(forKey: "RecentSearchs") as? [String] {
            self.recentSearchs = savedRecentSearchs
        }
    }
    
    func clearRecentSearchs() {
        UserDefaults.standard.removeObject(forKey: "RecentSearchs")
        self.recentSearchs = []
        // TODO: ReloadTableView gerekli
    }
    
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func getRecentWordsOutput() {
        // TODO:
    }
    
}
