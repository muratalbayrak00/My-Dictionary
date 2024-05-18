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
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTitle("Search Word")
        getRecentWordsOutput()
    }
    
    func numberOfItems() -> Int {
        return recentSearchs.count
    }
    
    func recentWords(_ index: Int) -> String? {
        return recentWords(index) // TODO: Burayi gereksiz olabilir tekrar bak.
    }
    
    func didSelectRowAt(_ index: Int) {
        print("Selected: \(recentSearchs[index] )")
        // TODO: Burada secilen cell e gore detail sayfasina yonlendirme yap.
//        guard let source = recentSearchs(index) else { return }
//        router.navigate(.detail(source: source))
        
    }
    
    private func getRecentSearchs() {
        // TODO: Show loading
        interactor.getRecentSearchs()
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    
    func getRecentWordsOutput() {
        // TODO:
    }
    
}
