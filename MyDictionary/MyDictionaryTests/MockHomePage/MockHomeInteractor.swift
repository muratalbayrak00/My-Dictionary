//
//  MockHomeInteractor.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import Foundation
@testable import MyDictionary

final class MockHomeInteractor: HomeInteractorProtocol {
    
    var isInvokedFetchRecent = false
    var invokedFetchRecentCount = 0
    
    func getRecentSearchs() {
        isInvokedFetchRecent = true
        invokedFetchRecentCount += 1
    }
    
}
