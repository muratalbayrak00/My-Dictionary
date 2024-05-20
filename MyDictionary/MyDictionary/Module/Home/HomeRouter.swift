//
//  HomeRouter.swift
//  MyDictionary
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation
import DictionaryApi

enum HomeRoutes {
   // case details(source: WordsData?)// TODO: burada string yerine RecentWords olabilir
    case details(searchText: String)// TODO: burada string yerine RecentWords olabilir
}

protocol HomeRouterProtocol {
    func navigate(_ route: HomeRoutes)
}

final class HomeRouter {
    
    weak var viewController: HomeViewController?
    
    
    static func createModule() -> HomeViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        
        return view
    }
}

extension HomeRouter: HomeRouterProtocol {
    // TODO: Detay sayfasini yap
    func navigate(_ route: HomeRoutes) {
        switch route {
        case .details(let text):
            let detailsVC = WordDetailRouter.createModule()
            detailsVC.searchText = text
            word = text
            viewController?.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
}
