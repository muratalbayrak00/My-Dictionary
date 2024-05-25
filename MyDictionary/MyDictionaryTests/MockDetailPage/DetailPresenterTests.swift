//
//  DetailPresenterTests.swift
//  MyDictionaryTests
//
//  Created by murat albayrak on 25.05.2024.
//

import XCTest
@testable import MyDictionary
import DictionaryApi

final class DetailPresenterTests: XCTestCase {

    var presenter: WordDetailPresenter!
    var mockView: MockDetailViewController!
    var mockInteractor: MockDetailInteractor!
    var mockRouter: MockDetailRouter!
    
    override func setUp() {
        super.setUp()
        mockView = MockDetailViewController()
        mockInteractor = MockDetailInteractor()
        mockRouter = MockDetailRouter()
        presenter = WordDetailPresenter(view: mockView, router: mockRouter, interactor: mockInteractor)
        presenter.wordTypes = WordsData.response.meanings?.compactMap { $0.partOfSpeech } ?? []
    }
    
    override func tearDown() {
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_NavigateToSynonym() {
        mockRouter.navigate(.synonym("synonym"))
        XCTAssertTrue(mockRouter.isNavigateInvoked)
        XCTAssertEqual(mockRouter.invokedNavigateParameters?.route, .synonym("synonym"))
    }
    
    func test_SetWordTitle() {
        mockView.setWordTitle("Test Word")
        XCTAssertTrue(mockView.setWordTitleInvoked)
        XCTAssertEqual(mockView.setWordTitleCount, 1)
    }
    
    func test_SetPhoneticLabel() {
        mockView.setPhoneticLabel("/(h)əʊm/")
        XCTAssertTrue(mockView.setPhoneticLabelInvoked)
        XCTAssertEqual(mockView.setPhoneticLabelCount, 1)
    }
    
    func test_ShowLoadingView() {
        mockView.showLoadingView()
        XCTAssertTrue(mockView.showLoadingViewInvoked)
        XCTAssertEqual(mockView.showLoadingViewCount, 1)
    }
    
    func test_HideLoadingView() {
        mockView.hideLoadingView()
        XCTAssertTrue(mockView.hideLoadingViewInvoked)
        XCTAssertEqual(mockView.hideLoadingViewCount, 1)
    }
    
    func test_ShowNotFound() {
        mockView.showNotFound()
        XCTAssertTrue(mockView.showNotFoundInvoked)
        XCTAssertEqual(mockView.showNotFoundCount, 1)
    }
    
    func test_GetSelectedFilter() {
        let selectedFilters = mockView.getSelectedFilter()
        XCTAssertTrue(mockView.getSelectedFilterInvoked)
        XCTAssertEqual(mockView.getSelectedFilterCount, 1)
        XCTAssertEqual(selectedFilters, [])
    }
    
    func test_HiddenFilterButtons() {
        mockView.hiddenFilterButtons(["noun", "verb"])
        XCTAssertTrue(mockView.hiddenFilterButtonsInvoked)
        XCTAssertEqual(mockView.hiddenFilterButtonsCount, 1)
    }
    
    func test_FetchWord() {
        presenter.fetchWordsFunc()
    }
    
    func test_FetchSynonyms() {
        presenter.fetchSynonymFunc()
    }
    
    func test_PlayAudio() {
        presenter.playAudio()
    }
    
    func test_FilterMeanings() {
        presenter.addFilteredMeaning()
    }
    
    func test_SetFilterButtonHidden() {
        presenter.setFilterButtonHidden()
    }
   
}

extension WordsData {
    
    static var response: WordsData {
        let bundle = Bundle(for: DetailPresenterTests.self)
        let path = bundle.path(forResource: "Word", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(WordsData.self, from: data)
        return response
    }
    
}

extension SynonymData {
    static var responseSynonym: SynonymData {
        let bundle = Bundle(for: DetailPresenterTests.self)
        let path = bundle.path(forResource: "Synonyms", ofType: "json")!
        let file = try! String(contentsOfFile: path)
        let data = file.data(using: .utf8)!
        let response = try! JSONDecoder().decode(SynonymData.self, from: data)
        return response
    }
}
