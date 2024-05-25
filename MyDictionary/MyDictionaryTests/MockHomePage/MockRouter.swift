//
//  MockRouter.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import Foundation
@testable import MyDictionary

final class MockRouter: HomeRouterProtocol {
    
    var isInvokedNavigate = false
    var invokedNavigateCount = 0
    var invokedNavigateParameters: (route: HomeRoutes, Void)?
    
    func navigate(_ route: MyDictionary.HomeRoutes) {
        isInvokedNavigate = true
        invokedNavigateCount += 1
        invokedNavigateParameters = (route, ())
    }
    
}
