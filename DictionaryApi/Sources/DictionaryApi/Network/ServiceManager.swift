//
//  File.swift
//  
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation


public protocol WordsServiceProtocol {
    func fetchWords(completion: @escaping(Result<[WordsData], NetworkError>) -> Void)
    func fetchSynonym(completion: @escaping(Result<[SynonymData], NetworkError>) -> Void)
}

extension API: WordsServiceProtocol {

    public func fetchWords(completion: @escaping (Result<[WordsData], NetworkError>) -> Void) {
        exequteRequestFor(router: .word, completion: completion)
    }
    
    public func fetchSynonym(completion: @escaping (Result<[SynonymData], NetworkError>) -> Void) {
        exequteRequestFor(router: .synonym, completion: completion)
    }
    
}
