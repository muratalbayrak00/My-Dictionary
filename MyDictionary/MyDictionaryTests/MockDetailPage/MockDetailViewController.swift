//
//  MockDetailViewController.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import Foundation
@testable import MyDictionary

final class MockDetailViewController: WordDetailViewControllerProtocol {
    
    var setTableViewHeightInvoked = false
    var setupTableViewInvoked = false
    var reloadDataInvoked = false
    var setWordTitleInvoked = false
    var setPhoneticLabelInvoked = false
    var showLoadingViewInvoked = false
    var hideLoadingViewInvoked = false
    var showNotFoundInvoked = false
    var getSelectedFilterInvoked = false
    var hiddenFilterButtonsInvoked = false
    
    var setTableViewHeightCount = 0
    var setupTableViewCount = 0
    var reloadDataCount = 0
    var setWordTitleCount = 0
    var setPhoneticLabelCount = 0
    var showLoadingViewCount = 0
    var hideLoadingViewCount = 0
    var showNotFoundCount = 0
    var getSelectedFilterCount = 0
    var hiddenFilterButtonsCount = 0
    
    func setTableViewHeight() {
        setTableViewHeightInvoked = true
        setTableViewHeightCount += 1  
    }
    
    func setupTableView() {
        setupTableViewInvoked = true
        setupTableViewCount += 1
    }
    
    func reloadData() {
        reloadDataInvoked = true
        reloadDataCount += 1
    }
    
    func setWordTitle(_ text: String) {
        setWordTitleInvoked = true
        setWordTitleCount += 1
    }
    
    func setPhoneticLabel(_ text: String) {
        setPhoneticLabelInvoked = true
        setPhoneticLabelCount += 1
    }
    
    func showLoadingView() {
        showLoadingViewInvoked = true
        showLoadingViewCount += 1
    }
    
    func hideLoadingView() {
        hideLoadingViewInvoked = true
        hideLoadingViewCount += 1
    }
    
    func showNotFound() {
        showNotFoundInvoked = true
        showNotFoundCount += 1
    }
    
    func getSelectedFilter() -> [String] {
        getSelectedFilterInvoked = true
        getSelectedFilterCount += 1
        return []
    }
    
    func hiddenFilterButtons(_ wordTypes: [String]) {
        hiddenFilterButtonsInvoked = true
        hiddenFilterButtonsCount += 1
    }
    
    
}
