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
    func word(_ index: Int) -> WordsData?
    func playAudio()

}

final class WordDetailPresenter {
    
    weak var view: WordDetailViewControllerProtocol?
    let router: WordDetailRouterProtocol! // TODO: force ve obtional i neye gore veriyoruz
    let interactor: WordDetailInteractorProtocol!
    
    private var word: [WordsData] = []
    private var player: AVPlayer?
    private var audioUrl: String = ""
    
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

    func viewDidLoad() {
        
        view?.setTableViewHeight()
        
        interactor.fetchWord()
        
        setTitleLabels()
    }
    
    func setTitleLabels() {
         DispatchQueue.main.async { // TODO: burayi viewWillApear a alabilirsin, asycn olmassa yoksa veriler gelmiyor
             self.view?.setWordTitle(self.word.first?.word ?? "error")
             self.view?.setPhoneticLabel(self.word.first?.phonetic ?? "error")
         }
    }
    
    func numberOfItems() -> Int {
        
        var sum: Int = 0
        for i in 0..<word.count {
            sum = sum + word[i].totalDefinitionsCount
    
        }
        print("Toplam defination sayisi: \(sum)")
        return sum
    }
    
    func word(_ index: Int) -> DictionaryApi.WordsData? {
        return word[safe: index] // TODO: ANlamadim burayi hata var tekrar bak
    }
    
    func playAudio() {
        
        if let audioUrl = URL(string: word.first?.phonetics.first?.audio ?? "") {
            player = AVPlayer(url: audioUrl)
            player?.play()
        }
        
    }
    
}

extension WordDetailPresenter: WordDetailInteractorOutputProtocol {
    
    func fetchWordOutput(result: WordsSourcesResult) {
        
        switch result {
        case .success(let response):
                //self.defination = response[0].meanings[0].definitions[0].definition
                self.word = response // burayi duzelt json orneklerine bak green ve run birbirinden farkli
                // print("Self Word:   \(self.word)")
        case .failure(let error):
            print(error.localizedDescription) // TODO:  view.showError(error.localizedDescription)
        }
        
    }
    
}
