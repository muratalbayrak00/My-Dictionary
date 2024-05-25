//
//  WordDetailRouter.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation
import DictionaryApi

enum WordDetailRoutes: Equatable { // Equatable for the unit tests
    case error
    case synonym(_ text: String)
}

protocol WordDetailRouterProtocol: AnyObject{
    func navigate(_ route: WordDetailRoutes)
    func navigateBackWithError()
}

final class WordDetailRouter {
    
    weak var viewController: WordDetailViewController?
    
    static func createModule() -> WordDetailViewController {
        let view = WordDetailViewController()
        let router = WordDetailRouter()
        let interactor = WordDetailInteractor()
        let presenter = WordDetailPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
        
    }
    
    func navigateBackWithError() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

extension WordDetailRouter: WordDetailRouterProtocol {

    func navigate(_ route: WordDetailRoutes) {
        switch route {
        case .error:
            let homeVC = HomeRouter.createModule()
            viewController?.navigationController?.pushViewController(homeVC, animated: true)
        case .synonym(let text):
            let detailsVC = WordDetailRouter.createModule()
            detailsVC.searchText = text
            word = text
         
            viewController?.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    
}
