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
    func numberOfItems() -> Int
    func getWord() -> [WordsData]?
    func word(_ index: Int) -> WordsData?
    func newWord(_ index: Int) -> NewWordData?
    func filteredMeanings(_ index: Int) -> NewWordData?
    func playAudio()
    func getFilteredMeanings() -> [NewWordData]
    func addFilteredMeaning()
    func getIsFiltering() -> Bool
    func updatedIsFiltering()
    func removeFilteredMeaning(_ text: String)
    func getSynonyms() -> [String]?
    func synonym(_ index: Int) -> String?
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
    var synonyms: [String] = ["Murat", "Baran", "telefone","deli","beni"]
    
    
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
    
    func getIsFiltering() -> Bool {
        return self.isFiltering
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
      //  print("after adding \(self.filteredMeanings)")
    }
    
    func removeFilteredMeaning(_ text: String) {
        
        self.filteredMeanings.removeAll { word in
            word.newPartOfSpeech?.lowercased() == text.lowercased()
        }
        view.reloadData()
       //print("after removing \(self.filteredMeanings)")
    }
    
    func updatedIsFiltering() {
        
        if !view.getSelectedFilter().isEmpty {
            self.isFiltering = true
        } else {
            self.isFiltering = false
        }
        
       // print("Is Filtering: \(isFiltering)")
        view.reloadData()
    }
    
    func viewDidLoad() {
        view.setupTableView()
        view.setTableViewHeight()
        view.reloadData()
        fetchWordsFunc()
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
    
    func numberOfItems() -> Int {
        
        var sum: Int = 0
        for i in 0..<self.word.count {
            sum = sum + word[i].totalDefinitionsCount
            
        }
        //print("Toplam defination sayisi: \(sum)")
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
    
    func getSynonyms() -> [String]? {
        return self.synonyms
    }
    
    func synonym(_ index: Int) -> String? {
        return self.synonyms[safe: index]
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
            view.reloadData()
        case .failure(let error):
            DispatchQueue.main.async {
                self.router.navigateBackWithError()
                self.view.showNotFound()
                //TODO: Fetch islemini home da yaptiktan sonra buraya tekrar bak
            }
            
            
            //view.showError(error.localizedDescription)
            // print(error.localizedDescription) // TODO:  view.showError(error.localizedDescription)
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
    
//    func setCombineMeanings(_ wordsData: [WordsData]) {
//        var allMeanings: [Meaning] = []
//        
//        for index in wordsData {
//            if let meanings = index.meanings {
//                allMeanings.append(contentsOf: meanings)
//            }
//        }
//        
//        if var firstWord = self.word.first {
//            firstWord.meanings = allMeanings.compactMap{$0}
//        }
//        
//    }
    
}
