//
//  MyDictionaryUITests.swift
//  MyDictionaryUITests
//
//  Created by murat albayrak on 18.05.2024.
//

import XCTest

final class MyDictionaryUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = true
        app = XCUIApplication()
        app.launchArguments.append("--- UI TEST STARTED")
    }
    
    func test_home_exist_element() {
        app.launch()
        XCTAssertTrue(app.isRecentSearchLabelDisplayed, "RecentSearchLabel not displayed")
        XCTAssertTrue(app.isClearButtonDisplayed, "ClearButton not displayed")
        XCTAssertTrue(app.isSearchButtonDisplayed, "SearchButton not displayed")
        
    }
    
    func test_detail_exist_element() {
        app.launch()
        
        let searchBarElement = app.otherElements["searchBar"]
        
        searchBarElement.tap()
        XCTAssertTrue(app.keyboards.firstMatch.exists)
        
        searchBarElement.typeText("Home")
        app.searchButton.tap()
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.wordTitleLabel)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        
        if result == .timedOut { // api gecikmesinden dolayi
            XCTAssertTrue(app.isWordTitleLabelDisplayed, "Word Title Label not displayed")

        }
        XCTAssertTrue(app.isNounFilterButtonDisplayed, "Noun Filter Button not displayed")
        XCTAssertTrue(app.isVerbFilterButtonDisplayed, "Verb Filter Button not displayed")
        XCTAssertTrue(app.isAdjectiveFilterButtonDisplayed, "Adjective Filter Button not displayed")
        XCTAssertTrue(app.isAdverbFilterButtonDisplayed, "Adverb Filter Button not displayed")
        XCTAssertTrue(app.isPlayAudioButtonDisplayed, "Play Audio Button not displayed")
       
        
    }
    
    func test_navigate_to_detail_view_controller() {
        app.launch()
        
        let searchBarElement = app.otherElements["searchBar"]
        
        searchBarElement.tap()
        XCTAssertTrue(app.keyboards.firstMatch.exists)
        
        searchBarElement.typeText("Home")
        app.searchButton.tap()
        let expectation = XCTNSPredicateExpectation(predicate: NSPredicate(format: "exists == true"), object: app.wordTitleLabel)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 1)
        if result == .timedOut {
            XCTAssertEqual(app.wordTitleLabel.label, "Home")
        }
        
        XCTAssertTrue(app.isWordTitleLabelDisplayed, "word title  label not displayed")
        
    }
    
    func test_click_clear_button() {
        app.launch()
        
        if app.isClearButtonDisplayed { // If recent search is not empty
            app.clearButton.tap()
            XCTAssertFalse(app.isClearButtonDisplayed, "Clear button not hidden")
        }
        
        
    }
    
    func test_click_noun_filter_button() {
        app.launch()
        
        let searchBarElement = app.otherElements["searchBar"]
        
        searchBarElement.tap()
        XCTAssertTrue(app.keyboards.firstMatch.exists)
        
        searchBarElement.typeText("Home")
        app.searchButton.tap()
        
        XCTAssertTrue(app.isNounFilterButtonDisplayed, "Noun filter button not displayed")
        
        app.nounFilterButton.tap()
        XCTAssertTrue(app.nounFilterButton.isSelected, "Noun filter button not selected")
        
        
    }
    
    func test_click_audio_button() {
        app.launch()
        
        let searchBarElement = app.otherElements["searchBar"]
        
        searchBarElement.tap()
        XCTAssertTrue(app.keyboards.firstMatch.exists)
        
        searchBarElement.typeText("Home")
        app.searchButton.tap()
        
        XCTAssertTrue(app.isPlayAudioButtonDisplayed, "Audio  button not displayed")

        app.playAudioButton.tap()
    }
    
    func test_multi_filtering_buttons() {
        app.launch()
        
        let searchBarElement = app.otherElements["searchBar"]
        
        searchBarElement.tap()
        XCTAssertTrue(app.keyboards.firstMatch.exists)
        
        searchBarElement.typeText("Home")
        app.searchButton.tap()
        
        XCTAssertTrue(app.isNounFilterButtonDisplayed, "Noun filter button not displayed")
        XCTAssertTrue(app.isAdverbFilterButtonDisplayed, "Adverb filter button not displayed")
        XCTAssertTrue(app.isVerbFilterButtonDisplayed, "Verb filter button not displayed")
        XCTAssertTrue(app.isAdjectiveFilterButtonDisplayed, "Adjective filter button not displayed")

        app.nounFilterButton.tap()
        app.verbFilterButton.tap()
        app.adjectiveFilterButton.tap()
        app.adverbFilterButton.tap()
        
        XCTAssertTrue(app.nounFilterButton.isSelected, "Noun filter button not selected")
        XCTAssertFalse(app.verbFilterButton.exists)
        XCTAssertFalse(app.adjectiveFilterButton.exists)
        XCTAssertFalse(app.adverbFilterButton.exists)

    }
    
    
    
}

extension XCUIApplication {
    
    var wordTitleLabel: XCUIElement {
        staticTexts.matching(identifier: "wordTitleLabel").element
    }
    
    var phoneticLabel: XCUIElement {
        staticTexts.matching(identifier: "phoneticLabel").element
    }
    
    var clearButton: XCUIElement {
        buttons["clearButton"]
    }
    
    var recentSearchLabel: XCUIElement {
        staticTexts.matching(identifier: "recentSearchLabel").element
    }
    
    var searchButton: XCUIElement {
        buttons["searchButton"]
    }
    
    var cancelFilterButton: XCUIElement {
        buttons["cancelFilterButton"]
    }
    
    var nounFilterButton: XCUIElement {
        buttons["nounFilterButton"]
    }
    
    var verbFilterButton: XCUIElement {
        buttons["verbFilterButton"]
    }
    
    var adjectiveFilterButton: XCUIElement {
        buttons["adjectiveFilterButton"]
    }
    
    var adverbFilterButton: XCUIElement {
        buttons["adverbFilterButton"]
    }
    
    var playAudioButton: XCUIElement {
        buttons["playAudioButton"]
    }
    
    var isClearButtonDisplayed: Bool {
        clearButton.exists
    }
    
    var isRecentSearchLabelDisplayed: Bool {
        recentSearchLabel.exists
    }
    
    var isSearchButtonDisplayed: Bool {
        searchButton.exists
    }
    
    var isCancelFilterButtonDisplayed: Bool {
        cancelFilterButton.exists
    }
    
    var isNounFilterButtonDisplayed: Bool {
        nounFilterButton.exists
    }
    
    var isVerbFilterButtonDisplayed: Bool {
        verbFilterButton.exists
    }
    
    var isAdjectiveFilterButtonDisplayed: Bool {
        adjectiveFilterButton.exists
    }
    
    var isAdverbFilterButtonDisplayed: Bool {
        adverbFilterButton.exists
    }
    
    var isPlayAudioButtonDisplayed: Bool {
        playAudioButton.exists
    }
    
    var isWordTitleLabelDisplayed: Bool {
        wordTitleLabel.exists
    }
    
    var isPhoneticLabelDisplayed: Bool {
        phoneticLabel.exists
    }
    

}
