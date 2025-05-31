//
//  WordCellPresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 20.05.2024.
//

import Foundation
import DictionaryApi

protocol WordCellPresenterProtocol: AnyObject {
    func load()
    func getHaveStatus() -> Bool
}

final class WordCellPresenter {
    
    weak var view: WordCellProtocol?
    private var word: NewWordData
    private var haveExample: Bool
    
    init(view: WordCellProtocol? = nil, word: NewWordData, haveExample: Bool) {
        self.view = view
        self.word = word
        self.haveExample = haveExample
    }
    
}

extension WordCellPresenter: WordCellPresenterProtocol {

    func getHaveStatus() -> Bool {
        return self.haveExample
    }
    
    func load() {
        
        setHiddenLabel()
        view?.setWordType(self.word.newPartOfSpeech ?? "")
        view?.setWordMeaning(self.word.newDefinition ?? "")
        view?.setExampleSentence(self.word.newExample ?? "")

    }
    
    func setHiddenLabel() {
        
        if word.newExample == nil || word.newExample == "" {
            view?.setHiddenExample(true) // set isHidden True
        } else {
            view?.setHiddenExample(false)
        }
        
    }
    
}



