//
//  MockHomeViewController.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import Foundation
@testable import MyDictionary

final class MockHomeViewController: HomeViewControllerProtocol {
    
    var isInvokedShowLoading = false
    var invokedShowLoadingCount = 0
    
    func showLoadingView() {
        isInvokedShowLoading = true
        invokedShowLoadingCount += 1
    }
    
    var isInvokedHideLoading = false
    var invokedHideLoadingCount = 0
    
    func hideLoadingView() {
        isInvokedHideLoading = true
        invokedHideLoadingCount += 1
    }
    
    var isInvokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        isInvokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var isInvokedSetupRecentTableView = false
    var invokedSetupRecentTableViewCount = 0
    
    func setupRecentTableView() {
        isInvokedSetupRecentTableView = true
        invokedSetupRecentTableViewCount += 1
    }
    
    var isInvokedShowError = false
    var invokedShowErrorCount = 0
    var invokedShowErrorParameters: (message: String, Void)?
    
    func showError(_ message: String) {
        isInvokedShowError = true
        invokedShowErrorCount += 1
        invokedShowErrorParameters = (message, ())
    }
    
    var invokedSetTitle = false
    var invokedSetTitleCount = 0
    var invokedSetTitleParameters: (title: String, Void)?
    
    func setTitle(_ title: String) {
        invokedSetTitle = true
        invokedSetTitleCount += 1
        invokedSetTitleParameters = (title, ())
    }
    
    var isInvokedSetRecentLabel = false
    var invokedSetRecentLabelCount = 0
    var invokedSetRecentLabelParameters: (title: String, Void)?
    
    func setRecentLabel(_ title: String) {
        isInvokedSetRecentLabel = true
        invokedSetRecentLabelCount += 1
        invokedSetRecentLabelParameters = (title, ())
    }
    
    var isInvokedHideClearButton = false
    var invokedHideClearButtonCount = 0
    
    func hideClearButton() {
        isInvokedHideClearButton = true
        invokedHideClearButtonCount += 1
    }
    
    var isInvokedShowClearButton = false
    var invokedShowClearButtonCount = 0
    
    func showClearButton() {
        isInvokedShowClearButton = true
        invokedShowClearButtonCount += 1
    }
    
    
}
