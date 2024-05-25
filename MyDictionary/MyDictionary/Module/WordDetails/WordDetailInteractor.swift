//
//  WordDetailInteractor.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation
import DictionaryApi


typealias WordsSourcesResult = Result<[WordsData], NetworkError>

typealias SynonymSourcesResult = Result<[SynonymData], NetworkError>

fileprivate var wordService: WordsServiceProtocol = API()

fileprivate var synonymService: WordsServiceProtocol = API()

protocol WordDetailInteractorProtocol: AnyObject {
    func fetchWord()
    func fetchSynonym()
}

protocol WordDetailInteractorOutputProtocol: AnyObject {
    func fetchWordOutput(result: WordsSourcesResult)
    func fetchSynonymOutput(result: SynonymSourcesResult)
}

final class WordDetailInteractor {
    var output: WordDetailInteractorOutputProtocol?

}

extension WordDetailInteractor: WordDetailInteractorProtocol {

    func fetchWord() {
        wordService.fetchWords { [weak self] result in
            guard let self else { return }
            self.output?.fetchWordOutput(result: result)
        }
    }
    
    func fetchSynonym() {
        synonymService.fetchSynonym { [weak self] result in
            guard let self else { return }
            self.output?.fetchSynonymOutput(result: result)
        }
    }
    
}
