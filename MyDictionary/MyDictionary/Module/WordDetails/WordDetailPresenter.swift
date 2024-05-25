//
//  WordDetailPresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation
import DictionaryApi
import AVFoundation


protocol WordDetailPresenterProtocol: AnyObject {
    
    func viewDidLoad()
    func playAudio()
    func addFilteredMeaning()
    func setIsFiltering()
    func updatedIsFiltering()

    func numberOfItems() -> Int
    func getIsFiltering() -> Bool
    func topSynonymButton(_ text: String)
    func removeFilteredMeaning(_ text: String)
    func getWordTypes() -> [String]

    func getWord() -> [WordsData]?
    func word(_ index: Int) -> WordsData?
    func newWord(_ index: Int) -> NewWordData?
    func filteredMeanings(_ index: Int) -> NewWordData?
    func getFilteredMeanings() -> [NewWordData]
    func getSynonyms() -> [SynonymData]?
    func synonym(_ index: Int) -> SynonymData?
    func getRouter() -> WordDetailRouterProtocol
    
    func viewWillAppear()
}

final class WordDetailPresenter {
    
    weak var view: WordDetailViewControllerProtocol!
    let router: WordDetailRouterProtocol! 
    let interactor: WordDetailInteractorProtocol!
    
    private var word: [WordsData] = []
    private var player: AVPlayer?
    private var audioUrl: String = ""
    private var newData: [NewWordData] = []
    private var filteredMeanings: [NewWordData] = []
    private var isFiltering: Bool = false
    private var synonyms: [SynonymData] = []
    private var topSynonyms: [NewSynonymData] = []
    private var wordTypes: [String] = []
    
    
    init(
        view: WordDetailViewControllerProtocol,
        router: WordDetailRouterProtocol,
        interactor: WordDetailInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
}

extension WordDetailPresenter: WordDetailPresenterProtocol {

    
    func getRouter() -> WordDetailRouterProtocol {
        return router
    }
    
    func getIsFiltering() -> Bool {
        return self.isFiltering
    }
    
    func setIsFiltering() {
        
        if isFiltering {
            isFiltering = false
        } else {
            isFiltering = true
        }
    }
    
    func getWordTypes() -> [String] {
        return self.wordTypes
    }
    
    func getFilteredMeanings() -> [NewWordData] {
        return self.filteredMeanings
    }
    
    func addFilteredMeaning() {
        
        for type in view.getSelectedFilter() {
            for word in self.newData {
                if word.newPartOfSpeech == type.lowercased() {
                    self.filteredMeanings.append(word)
                }
            }
        }
        self.filteredMeanings = Array(Set(filteredMeanings))
        
        view.reloadData()
    }
    
    func removeFilteredMeaning(_ text: String) {
        
        self.filteredMeanings.removeAll { word in
            word.newPartOfSpeech?.lowercased() == text.lowercased()
        }
        view.reloadData()
    }
    
    func updatedIsFiltering() {
        
        if !view.getSelectedFilter().isEmpty {
            self.isFiltering = true
        } else {
            self.isFiltering = false
        }
        
        view.reloadData()
    }
    
    func viewDidLoad() {
        view.setupTableView()
        fetchWordsFunc()
        view.reloadData()
        fetchSynonymFunc()
        view.reloadData()
    }
    
    func viewWillAppear() {
        fetchSynonymFunc()
        view.reloadData()
    }
    
    func setFilterButtonHidden() {
        var tempWordTypes: [String] = []
        for meaning in newData {
            if let type = meaning.newPartOfSpeech {
                tempWordTypes.append(type.lowercased())
            }
        }
        self.wordTypes = Array(Set(tempWordTypes))

    }
    
    func setTitleLabels() {
        
        DispatchQueue.main.async {
            self.view.setWordTitle(self.word.first?.word ?? "error")
            self.view.setPhoneticLabel(self.word.first?.phonetic ?? "error")
        }
        
    }
    
    func fetchWordsFunc() {
        view.showLoadingView()
        interactor.fetchWord()
    }
    
    func fetchSynonymFunc() {
        interactor.fetchSynonym()
        view.reloadData()
    }
    
    func numberOfItems() -> Int {
        
        var sum: Int = 0
        for i in 0..<self.word.count {
            sum = sum + word[i].totalDefinitionsCount
            
        }
        return sum
    }
    
    func word(_ index: Int) -> DictionaryApi.WordsData? {
        return self.word[safe: index]
    }
    
    func newWord(_ index: Int) -> NewWordData? {
        return self.newData[safe: index]
    }
    
    func filteredMeanings(_ index: Int) -> NewWordData? {
        return self.filteredMeanings[safe: index]
    }
    
    func getWord() -> [DictionaryApi.WordsData]? {
        return self.word
    }
    
    func playAudio() {
        guard let phonetics = word.first?.phonetics else {
            return
        }
        if let audioUrlString = phonetics.first(where: { $0.audio != nil && !$0.audio!.isEmpty })?.audio,
           let audioUrl = URL(string: audioUrlString) {
            player = AVPlayer(url: audioUrl)
            player?.play()
        }
    }
    
    func getSynonyms() -> [SynonymData]? {
        return self.synonyms
    }
    
    func synonym(_ index: Int) -> SynonymData? {
        return self.synonyms[safe: index]
    }
    
    func topSynonymButton(_ text: String) {
        router.navigate(.synonym(text))
    }
    
}

extension WordDetailPresenter: WordDetailInteractorOutputProtocol {
    
    func fetchWordOutput(result: WordsSourcesResult) {
        self.view.hideLoadingView()
        switch result {
        case .success(let response):
            self.word = response
            setTitleLabels()
            setCellDefinitions()
            setFilterButtonHidden()
            view.hiddenFilterButtons(wordTypes)
            view.reloadData()
        case .failure(let error):

            DispatchQueue.main.async {
                self.router.navigateBackWithError()
                self.view.showNotFound()
                print(error.localizedDescription)
            }

        }
    }
    
    func fetchSynonymOutput(result: SynonymSourcesResult) {
        switch result {
        case .success(let response):
            self.synonyms = response
            view.reloadData()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func setCellDefinitions() {
        
        for i in word {
            if let meanings = i.meanings {
                for meaning in meanings {
                    if let definitions = meaning.definitions {
                        for definition in definitions {
                            let newDefinition = NewWordData(newPartOfSpeech: meaning.partOfSpeech, newDefinition: definition.definition, newExample: definition.example)
                            self.newData.append(newDefinition)
                        }
                    }
                }
            }
        }
        
    }
    
}
