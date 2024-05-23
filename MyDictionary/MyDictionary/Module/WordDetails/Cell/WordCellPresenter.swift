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
    //private var word: WordsData
    private var word: NewWordData
    
    init(view: WordCellProtocol? = nil, word: NewWordData) {
        self.view = view
        self.word = word
    }
    
}

extension WordCellPresenter: WordCellPresenterProtocol {
    
    func load() {
        //TODO: gelen json a gore burayi duzenle
        view?.setWordType(self.word.newPartOfSpeech ?? "Tur")
        view?.setWordMeaning(self.word.newDefinition ?? "Anlam")
        
      //  view?.setExampleLabel("Example")
        view?.setExampleSentence(self.word.newExample ?? "Yok")
//        guard let meanings = word.meanings else {
//                    view?.setWordType("N/A")
//                    view?.setWordMeaning("Anlam mevcut değil")
//                    view?.setExampleLabel("Örnek")
//                    view?.setExampleSentence("Örnek mevcut değil")
//                    return
//                }
//                
//                // Tüm meanings ve definitions'ları işle
//                for meaning in meanings {
//                    if let partOfSpeech = meaning.partOfSpeech {
//                        view?.setWordType(partOfSpeech)
//                    }
//                    
//                    if let definitions = meaning.definitions {
//                        for definition in definitions {
//                            if let definitionText = definition.definition {
//                                view?.setWordMeaning(definitionText)
//                            }
//                            
//                            if let example = definition.example {
//                                view?.setExampleLabel("Örnek")
//                                view?.setExampleSentence(example)
//                            }
//                        }
//                    }
//                }
    }
    
}



