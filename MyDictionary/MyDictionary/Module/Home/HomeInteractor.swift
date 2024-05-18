//
//  HomeInteractor.swift
//  MyDictionary
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

protocol HomeInteractorProtocol: AnyObject {
    func getRecentSearchs()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func getRecentWordsOutput()
}

final class HomeInteractor {
    
    var output: HomeInteractorOutputProtocol?
    
}

extension HomeInteractor: HomeInteractorProtocol {
    
    func getRecentSearchs() {
        // TODO: Burayi hallet
    }

}

