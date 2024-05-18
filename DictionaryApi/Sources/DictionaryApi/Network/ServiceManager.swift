//
//  File.swift
//  
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

protocol WordsServiceProtocol {
    func fetchWords(completion: @escaping(Result<WordsData, NetworkError>) -> Void)
}

extension API: WordsServiceProtocol {
    
    func fetchWords(completion: @escaping (Result<WordsData, NetworkError>) -> Void) {
        exequteRequestFor(router: .word, completion: completion)
    }
}
