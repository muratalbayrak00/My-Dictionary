//
//  WordDetailPresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation
import DictionaryApi

protocol WordDetailPresenterProtocol: AnyObject {
    func viewDidLoad()
}

final class WordDetailPresenter {
    
    weak var view: WordDetailViewControllerProtocol?
    let router: WordDetailRouterProtocol! // TODO: force ve obtional i neye gore veriyoruz
    let interactor: WordDetailInteractorProtocol!
    
    private var defination: String = ""
    
    init(
        view: WordDetailViewControllerProtocol,
        router: WordDetailRouterProtocol,
        interactor: WordDetailInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    
}

extension WordDetailPresenter: WordDetailPresenterProtocol {
    
    func viewDidLoad() {
        fetchWord()
        view?.setTestLabel(defination)
    }
    
    func fetchWord(){
        interactor.fetchWord()
    }
    
}

extension WordDetailPresenter: WordDetailInteractorOutputProtocol {
    
    func fetchWordOutput(result: WordsSourcesResult) {
        switch result {
        case .success(let response):
            self.defination = response[0].meanings[0].definitions[0].definition
            print("selfmeaning: \(self.defination)")
            view?.setTestLabel(defination)
        case .failure(let error):
            print(error.localizedDescription) // TODO:  view.showError(error.localizedDescription)
        }
        
    }
    
}
