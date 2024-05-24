//
//  FooterCellPresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 24.05.2024.
//

import Foundation
import DictionaryApi

protocol FooterCellPresenterProtocol: AnyObject {
    func load()
}

final class FooterCellPresenter {
    
    weak var view: FooterCellProtocol?
    private var synonyms: [SynonymData]
    
    init(view: FooterCellProtocol? = nil, synonyms: [SynonymData]) {
        self.view = view
        self.synonyms = synonyms
    }
    
}

extension FooterCellPresenter: FooterCellPresenterProtocol {
 
    func load() {
        
        getTopScoreSynonyms()
        
        if synonyms.count >= 5 {
            view?.setSysonymButton1(self.synonyms[0].word ?? "")
            view?.setSysonymButton2(self.synonyms[1].word ?? "")
            view?.setSysonymButton3(self.synonyms[2].word ?? "")
            view?.setSysonymButton4(self.synonyms[3].word ?? "")
            view?.setSysonymButton5(self.synonyms[4].word ?? "")
        }
    
    }
    
    func getTopScoreSynonyms() {
        
        var topSynonyms: [SynonymData]
        
        topSynonyms = synonyms
            .compactMap { $0 }
            .sorted { ($0.score ?? 0) > ($1.score ?? 0) }
            .prefix(5)
            .map { $0 }
        
        synonyms = topSynonyms
    }
    
}
