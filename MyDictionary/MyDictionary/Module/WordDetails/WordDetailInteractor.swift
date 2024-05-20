//
//  WordDetailInteractor.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation
import DictionaryApi


fileprivate var wordService: WordsServiceProtocol = API() // WordsServiceProtocol bunu service ten cekemiyor buna tekrar bak

typealias WordsSourcesResult = Result<[WordsData], NetworkError>



protocol WordDetailInteractorProtocol: AnyObject {
    func fetchWord()
}

protocol WordDetailInteractorOutputProtocol: AnyObject {
    func fetchWordOutput(result: WordsSourcesResult)
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
    
}
