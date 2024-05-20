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
}

final class WordCellPresenter {
    
    
    weak var view: WordCellProtocol?
    private let word: WordsData
    
    init(view: WordCellProtocol? = nil, word: WordsData) {
        self.view = view
        self.word = word
    }
    
}

extension WordCellPresenter: WordCellPresenterProtocol {
    
    func load() {
        //TODO: gelen json a gore burayi duzenle 
        view?.setWordType(word.meanings.first?.partOfSpeech ?? "Bosluk")
        view?.setWordMeaning(word.meanings.first?.definitions.first?.definition ?? "Boslukk")
        view?.setExampleLabel("Example")
        view?.setExampleSentence(word.meanings.first?.definitions.first?.example ?? "Bosslukk")
    }
    
}



