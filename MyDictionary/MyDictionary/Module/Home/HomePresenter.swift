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
    func topSearch()
    func updateRecentWords(_ text: String)
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
        self.recentSearchs.append(text)
    }
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("Search Word")
        view.setRecentLabel("Recent Search")
        getRecentWordsOutput()
    }
    
    func numberOfItems() -> Int {
        return recentSearchs.count
    }
    
    func recentWords(_ index: Int) -> String? {
        return recentSearchs[index] // TODO: Burayi gereksiz olabilir tekrar bak.
    }
    
    func didSelectRowAt(_ index: Int) {
        print("Selected: \(recentSearchs[index] )")
        // TODO: Burada secilen cell e gore detail sayfasina yonlendirme yap.
//        guard let source = recentSearchs(index) else { return }
//        router.navigate(.detail(source: source))
        
    }
    
    private func getRecentSearchs() -> [String] {
        // TODO: Show loading
        return recentSearchs
       // interactor.getRecentSearchs()
    }
    
    func topSearch() {
        // fetch word here 
    }
    
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func getRecentWordsOutput() {
        // TODO:
    }
    
}
