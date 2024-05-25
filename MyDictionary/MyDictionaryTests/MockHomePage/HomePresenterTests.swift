//
//  HomePresenterTests.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import XCTest
@testable import MyDictionary

final class HomePresenterTests: XCTestCase {
    
    var presenter: HomePresenter!
    var view: MockHomeViewController!
    var interactor: MockHomeInteractor!
    var router: MockRouter!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(view: view, router: router, interactor: interactor)
        
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    func test_ViewDidLoad() {
        XCTAssertFalse(view.isInvokedShowLoading)
        
        presenter.viewDidLoad()
        
        XCTAssertTrue(view.invokedSetTitle)
        XCTAssertEqual(view.invokedSetTitleParameters?.title, "Search Word")
        XCTAssertEqual(view.invokedSetTitleCount, 1)
        XCTAssertTrue(view.isInvokedSetupRecentTableView)
    }
    
    func test_UpdateRecentWordsAddsNewWord() {
        XCTAssertFalse(view.isInvokedShowLoading)
        
        presenter.updateRecentWords("Home")
        
        XCTAssertTrue(view.isInvokedShowClearButton)
        XCTAssertTrue(presenter.numberOfItems() == 1)
    }
    
    func test_UpdateRecentWordsDoesNotAddDuplicate() {
        presenter.updateRecentWords("Home")
        
        presenter.updateRecentWords("Home")
        
        XCTAssertTrue(presenter.numberOfItems() == 1)
    }
    
    func test_ClearRecentSearchs() {
        presenter.updateRecentWords("Home")
        
        presenter.clearRecentSearchs()
        
        XCTAssertTrue(presenter.numberOfItems() == 0)
        XCTAssertTrue(view.isInvokedHideClearButton)
    }
    
    func test_TopSearchButtonNavigatesToDetails() {
        let searchText = "Home"
        
        presenter.topSearchButton(searchText)
        
        XCTAssertTrue(router.isInvokedNavigate)
        XCTAssertEqual(router.invokedNavigateParameters?.route, .details(searchText: searchText))
    }
}

