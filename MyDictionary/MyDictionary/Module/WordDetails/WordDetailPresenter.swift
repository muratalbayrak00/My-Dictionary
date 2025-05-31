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
    
    func addFilteredMeaning() { // TODO: filtreleme hatasi var verb / adverb
        var counts: [String: Int] = [:] // Her bir part of speech için sayıcı

        for type in view.getSelectedFilter() {
            for word in self.newData {
                if let partOfSpeech = word.newPartOfSpeech, partOfSpeech.range(of: type.lowercased()) != nil {
                    let key = partOfSpeech.lowercased()
                    counts[key, default: 0] += 1 // Part of speech'e göre sayıcıyı artır
                    self.filteredMeanings.append(word)
                }
            }
        }

        // filteredMeanings dizisini partOfSpeech ve numaralandırmaya göre sırala
        self.filteredMeanings.sort { (word1, word2) -> Bool in
            guard let pos1 = word1.newPartOfSpeech, let pos2 = word2.newPartOfSpeech else {
                return false
            }
            // Part of speech ve numaraları ayır
            let components1 = pos1.components(separatedBy: "-")
            let components2 = pos2.components(separatedBy: "-")

            guard components1.count >= 2 && components2.count >= 2 else {
                return false
            }

            let pos1Value = components1[1]
            let pos2Value = components2[1]

            // Part of speech'e göre sıralama yap
            if pos1Value != pos2Value {
                return pos1Value < pos2Value
            } else {
                // Part of speech aynıysa, numaralara göre sıralama yap
                let num1 = Int(components1[0]) ?? 0
                let num2 = Int(components2[0]) ?? 0
                return num1 < num2
            }
        }
                
        view.reloadData()
    }
    
    func removeFilteredMeaning(_ text: String) {
        
        self.filteredMeanings.removeAll { word in
            word.newPartOfSpeech?.range(of: text.lowercased()) != nil
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
    
    func setCellDefinitions() { // burayi hallet hata kelime turlerin  basina 1 2 falan koyuyor fakat filtreleme buttonlari ekrana cikmiyor cunku
        
        var counter: [String: Int] = [:]
        
        for i in word {
            if let meanings = i.meanings {
                for meaning in meanings {
                    if let definitions = meaning.definitions {
                        for definition in definitions {
                            let newDefinition = NewWordData(newPartOfSpeech: meaning.partOfSpeech, newDefinition: definition.definition, newExample: definition.example)
                            self.newData.append(newDefinition)
                            
                            if let partOfSpeech = meaning.partOfSpeech {
                                let key = partOfSpeech.lowercased()
                                counter[key] = (counter[key] ?? 0) + 1
                            }
                        }
                    }
                }
            }
        }
        

        
        newData.sort { (data1, data2) -> Bool in
            let order = ["noun", "verb", "adverb", "adjective"]
            if let index1 = order.firstIndex(of: data1.newPartOfSpeech ?? ""),
               let index2 = order.firstIndex(of: data2.newPartOfSpeech ?? "") {
                // Kelimenin hangi sırada olduğunu bulun
                let count1 = counter[data1.newPartOfSpeech?.lowercased() ?? ""] ?? 0
                let count2 = counter[data2.newPartOfSpeech?.lowercased() ?? ""] ?? 0
                
                // Sıralamayı belirleyin
                if index1 == index2 {
                    return count1 < count2 // Aynı türdeki kelimeler arasında sayaça göre sırala
                } else {
                    return index1 < index2 // Farklı türler arasında sırala
                }
            }
            return false
        }
        
        var currentCounts: [String: Int] = [:]
        for (index, data) in newData.enumerated() {
            let key = data.newPartOfSpeech?.lowercased() ?? ""
            let count = currentCounts[key, default: 0] + 1
            currentCounts[key] = count
            newData[index].newPartOfSpeech = "\(count)-\(data.newPartOfSpeech ?? "")"
        }
        
    }
    
}
