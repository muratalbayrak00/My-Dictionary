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
    func didSelectRowAt(_ index: Int)
    func topSearchButton(_ searchText: String)
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
        view.showClearButton()
        if !recentSearchs.contains(text.lowercased()){
            if recentSearchs.count < 5 {
                recentSearchs.insert(text.lowercased(), at: 0)

            } else {
                recentSearchs = Array(recentSearchs.dropLast())
                recentSearchs.insert(text.lowercased(), at: 0)
            }
            
            UserDefaults.standard.set(recentSearchs, forKey: "RecentSearchs")
        }
    }
    
    func viewDidLoad() {
        view.setupRecentTableView()
        view.setTitle("Search Word")
        view.setRecentLabel("Recent Search")
        setRecentSearchs()
        setClearButtonVisibility()
    }
    
    func setRecentSearchs() {
        if let savedRecentSearchs = UserDefaults.standard.array(forKey: "RecentSearchs") as? [String] {
            self.recentSearchs = savedRecentSearchs

        }
    }
    
    func clearRecentSearchs() {
        UserDefaults.standard.removeObject(forKey: "RecentSearchs")
        self.recentSearchs = []
        view.hideClearButton()
    }

    
    func numberOfItems() -> Int {
        return recentSearchs.count
    }
    
    func recentWords(_ index: Int) -> String? {
        return recentSearchs[index] 
    }
    
    func didSelectRowAt(_ index: Int) {
        let recentText = self.recentSearchs[index]
        router.navigate(.details(searchText: recentText))
    }
    
    private func getRecentSearchs() -> [String] {
        return self.recentSearchs
    }
    
    func topSearchButton(_ searchText: String) {
        router.navigate(.details(searchText: searchText))
    }
    
    func setClearButtonVisibility() {
        
        if recentSearchs.isEmpty {
            view.hideClearButton()
        } else {
            view.showClearButton()
        }
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func getRecentWordsOutput() -> [String] {
        return recentSearchs
    }
    
}
