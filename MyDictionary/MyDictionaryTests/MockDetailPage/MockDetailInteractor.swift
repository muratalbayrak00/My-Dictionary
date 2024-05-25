//
//  MockDetailInteractor.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import Foundation
@testable import MyDictionary

final class MockDetailInteractor: WordDetailInteractorProtocol {
    
    var fetchWordCalled = false
    var fetchSynonymCalled = false
    
    func fetchWord() {
        fetchWordCalled = true
    }
    
    func fetchSynonym() {
        fetchSynonymCalled = true
    }
    
    
}
