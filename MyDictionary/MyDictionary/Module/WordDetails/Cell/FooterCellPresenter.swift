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
        self.getTopScoreSynonyms()
        DispatchQueue.main.async {
        
            switch self.synonyms.count {
            case let count where count >= 5:
                self.view?.setSysonymButton1(self.synonyms[0].word ?? "")
                self.view?.setSysonymButton2(self.synonyms[1].word ?? "")
                self.view?.setSysonymButton3(self.synonyms[2].word ?? "")
                self.view?.setSysonymButton4(self.synonyms[3].word ?? "")
                self.view?.setSysonymButton5(self.synonyms[4].word ?? "")
            case 4:
                self.view?.setSysonymButton1(self.synonyms[0].word ?? "")
                self.view?.setSysonymButton2(self.synonyms[1].word ?? "")
                self.view?.setSysonymButton3(self.synonyms[2].word ?? "")
                self.view?.setSysonymButton4(self.synonyms[3].word ?? "")
                self.view?.setHiddenButton5(true)
            case 3:
                self.view?.setSysonymButton1(self.synonyms[0].word ?? "")
                self.view?.setSysonymButton2(self.synonyms[1].word ?? "")
                self.view?.setSysonymButton3(self.synonyms[2].word ?? "")
                self.view?.setHiddenButton5(true)
                self.view?.setHiddenButton4(true)
            case 2:
                self.view?.setSysonymButton1(self.synonyms[0].word ?? "")
                self.view?.setSysonymButton2(self.synonyms[1].word ?? "")
                self.view?.setHiddenButton5(true)
                self.view?.setHiddenButton4(true)
                self.view?.setHiddenButton3(true)
            case 1:
                self.view?.setSysonymButton1(self.synonyms[0].word ?? "")
                self.view?.setHiddenButton5(true)
                self.view?.setHiddenButton4(true)
                self.view?.setHiddenButton3(true)
                self.view?.setHiddenButton2(true)
            case 0:
                self.view?.setHiddenButton5(true)
                self.view?.setHiddenButton4(true)
                self.view?.setHiddenButton3(true)
                self.view?.setHiddenButton2(true)
                self.view?.setSysonymButton1("Synonyms not found")
                self.view?.setDisableButton1(false)
                print("Hicbir synonymi yokkk*************")
            default:
                break
            }

        }
    }
    
    func getTopScoreSynonyms() {
        
        var topSynonyms: [SynonymData] = []
        
        topSynonyms = synonyms
            .compactMap { $0 }
            .sorted { ($0.score ?? 0) > ($1.score ?? 0) }
            .prefix(5)
            .map { $0 }
        
        synonyms.removeAll()
        synonyms.append(contentsOf: topSynonyms)
       // self.synonyms = topSynonyms
        

    }
    
}
