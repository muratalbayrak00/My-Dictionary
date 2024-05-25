//
//  MockDetailRouter.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import Foundation
@testable import MyDictionary


final class MockDetailRouter: WordDetailRouterProtocol {

    var isNavigateInvoked = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: WordDetailRoutes, Void)?
    
    func navigate(_ route: MyDictionary.WordDetailRoutes) {
        isNavigateInvoked = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
    
    func navigateBackWithError() {
        isNavigateInvoked = true
        invokedNavigateCount += 1
    }
    
    
}
