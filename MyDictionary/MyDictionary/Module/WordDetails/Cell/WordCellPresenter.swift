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
    //private var word: WordsData
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
        //TODO: gelen json a gore burayi duzenle
        view?.setWordType(self.word.newPartOfSpeech ?? "")
        view?.setWordMeaning(self.word.newDefinition ?? "")
        
      //  view?.setExampleLabel("Example")
        view?.setExampleSentence(self.word.newExample ?? "")
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



