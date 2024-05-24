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
    func viewWillAppear()
    func numberOfItems() -> Int
    func getWord() -> [WordsData]?
    func word(_ index: Int) -> WordsData?
    func newWord(_ index: Int) -> NewWordData?
    func filteredMeanings(_ index: Int) -> NewWordData?
    func playAudio()
    func getFilteredMeanings() -> [NewWordData]
    func addFilteredMeaning()
    func getIsFiltering() -> Bool
    func setIsFiltering()
    func getWordTypes() -> [String]
    func updatedIsFiltering()
    func removeFilteredMeaning(_ text: String)
    func getSynonyms() -> [SynonymData]?
    func synonym(_ index: Int) -> SynonymData?
    func topSynonymButton(_ text: String)
    func getRouter() -> WordDetailRouterProtocol
}

final class WordDetailPresenter {
    
    weak var view: WordDetailViewControllerProtocol!
    let router: WordDetailRouterProtocol! // TODO: force ve obtional i neye gore veriyoruz
    let interactor: WordDetailInteractorProtocol!
    
    private var word: [WordsData] = []
    private var player: AVPlayer?
    private var audioUrl: String = ""
    var newData: [NewWordData] = []
    var filteredMeanings: [NewWordData] = []
    var isFiltering: Bool = false
    var synonyms: [SynonymData] = []
    var topSynonyms: [NewSynonymData] = []
    var wordTypes: [String] = []
    
    
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
        // pop yapmayi unutma append yapiyoruz fakat tekrar basinca pop yapmak lazim filered menaings e
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
        view.setTableViewHeight()
        fetchWordsFunc()
        view.reloadData()
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
       // print("tempWordTypes \(tempWordTypes)")
        self.wordTypes = Array(Set(tempWordTypes))
        //print("wordtypes \(self.wordTypes)")

    }
    
    func viewWillAppear() {

    }
    
    func setTitleLabels() {
        
        DispatchQueue.main.async { // TODO: burayi viewWillApear a alabilirsin, asycn olmassa yoksa veriler gelmiyor
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
        return self.word[safe: index] // TODO: ANlamadim burayi hata var tekrar bak
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
        // TODO: bu kullanimin ismi ne
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
            self.word = response // burayi duzelt json orneklerine bak green ve run birbirinden farkli
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
                //TODO: Fetch islemini home da yaptiktan sonra buraya tekrar bak
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
    
    func setCellDefinitions() { // TODO: bu fonksiyonun ismini degistir.
        
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
