//
//  File.swift
//  
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation

//public var wordService: WordsServiceProtocol = API() // WordsServiceProtocol bunu service ten cekemiyor buna tekrar bak

public protocol WordsServiceProtocol {
    func fetchWords(completion: @escaping(Result<[WordsData], NetworkError>) -> Void)
}

extension API: WordsServiceProtocol {
    
    public func fetchWords(completion: @escaping (Result<[WordsData], NetworkError>) -> Void) {
        exequteRequestFor(router: .word, completion: completion)
    }
}
