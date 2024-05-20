//
//  WordDetailRouter.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation

protocol WordDetailRouterProtocol: AnyObject{
    func navigate(_ route: WordDetailRouter)
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
}

extension WordDetailRouter: WordDetailRouterProtocol {
    
    func navigate(_ route: WordDetailRouter) {
        
    }
    
}
