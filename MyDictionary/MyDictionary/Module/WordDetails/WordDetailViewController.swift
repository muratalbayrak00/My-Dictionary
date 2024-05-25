//
//  WordDetailViewController.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import UIKit
import DictionaryApi

protocol WordDetailViewControllerProtocol: AnyObject {
    
    func setupTableView()
    func reloadData()
    func setWordTitle(_ text: String)
    func setPhoneticLabel(_ text: String)
    func showLoadingView()
    func hideLoadingView()
    func showNotFound()
    func getSelectedFilter() -> [String]
    func hiddenFilterButtons(_ wordTypes: [String])
    
}

class WordDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    
    @IBOutlet weak var phoneticLabel: UILabel!
    
    var selectedFilterButtons: [String] = []
    
    var presenter: WordDetailPresenterProtocol!
    
    var searchText: String = ""
    
    @IBOutlet weak var cancelFilterButton: UIButton!
    
    @IBOutlet weak var nounFilterButton: UIButton!
    
    @IBOutlet weak var verbFilterButton: UIButton!
    
    @IBOutlet weak var adjectiveFilterButton: UIButton!
    
    @IBOutlet weak var adverbFilterButton: UIButton!
    
    @IBOutlet weak var playAudioButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        setAccessibilityIdentifiers()
        tableView.reloadData()
        
        cancelFilterButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func hiddenFilterButtons(_ wordTypes: [String]) {
        
        DispatchQueue.main.async {
            if !self.presenter.getWordTypes().contains(where: { $0 == "noun" }) {
                
                self.nounFilterButton.isHidden = true
                
            } else {
                
                self.nounFilterButton.isHidden = false
            }
            if !self.presenter.getWordTypes().contains(where: { $0 == "verb" }) {
    
                self.verbFilterButton.isHidden = true
                
            } else {
                
                self.verbFilterButton.isHidden = false

            }
            if !self.presenter.getWordTypes().contains(where: { $0 == "adjective" }) {
                
                self.adjectiveFilterButton.isHidden = true
                
            } else {
                
                self.adjectiveFilterButton.isHidden = false

            }
            if !self.presenter.getWordTypes().contains(where: { $0 == "adverb" }) {
                
                self.adverbFilterButton.isHidden = true
                
            } else {
                
                self.adverbFilterButton.isHidden = false
                
            }
                
        }
        
    }
    
    @IBAction func cancelFilterButton(_ sender: Any) {
        clearAllFilter()
    }
    
    func clearAllFilter() {
        
        selectedFilterButtons.removeAll()
        presenter.updatedIsFiltering()
        setButtonsNonSelected()
        cancelFilterButton.isHidden = true
        setHiddenFalse()
        hiddenFilterButtons(presenter.getWordTypes())
        tableView.reloadData()
        
    }
    
    func setHiddenFalse() {
        
    }
    
    func setButtonsNonSelected() {
        
        nounFilterButton.isSelected = false
        verbFilterButton.isSelected = false
        adverbFilterButton.isSelected = false
        adjectiveFilterButton.isSelected = false
        
        presenter.removeFilteredMeaning("noun")
        presenter.removeFilteredMeaning("verb")
        presenter.removeFilteredMeaning("adjective")
        presenter.removeFilteredMeaning("adverb")
        
    }
    
    @IBAction func nounFilterButton(_ sender: Any) {
        
        if nounFilterButton.isSelected {
            
            nounFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.updatedIsFiltering()
            presenter.removeFilteredMeaning("noun")
            clearAllFilter()
            tableView.reloadData()
            
            if selectedFilterButtons.count == 0 {
                cancelFilterButton.isHidden = true
            }
            
        } else {
            
            nounFilterButton.isSelected = true
            cancelFilterButton.isHidden = false
            
            if let text = nounFilterButton.titleLabel?.text {
                selectedFilterButtons.append(text)
                presenter.addFilteredMeaning()
                presenter.updatedIsFiltering()
                multiFilteringButton()
                tableView.reloadData()
                
            }
        }
        
    }
    
    @IBAction func verbFilterButton(_ sender: Any) {
        
        if verbFilterButton.isSelected {
            
            verbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.removeFilteredMeaning("verb")
            presenter.updatedIsFiltering()
            clearAllFilter()
            tableView.reloadData()
            
            if selectedFilterButtons.isEmpty {
                cancelFilterButton.isHidden = true
            }
            
        } else {
            
            cancelFilterButton.isHidden = false
            verbFilterButton.isSelected = true
            
            if let text = verbFilterButton.titleLabel?.text {
                
                self.selectedFilterButtons.append(text)
                presenter.addFilteredMeaning()
                presenter.updatedIsFiltering()
                multiFilteringButton()
                tableView.reloadData()
            }
        }
    }
    
    @IBAction func adjectiveFilterButton(_ sender: Any) {
        
        if adjectiveFilterButton.isSelected {
            adjectiveFilterButton.isSelected = false
            
            selectedFilterButtons.removeLast()
            presenter.removeFilteredMeaning("adjective")
            presenter.updatedIsFiltering()
            clearAllFilter()
            tableView.reloadData()
            
            if selectedFilterButtons.isEmpty {
                cancelFilterButton.isHidden = true
            }
            
        } else {
            
            cancelFilterButton.isHidden = false
            adjectiveFilterButton.isSelected = true
            
            if let text = adjectiveFilterButton.titleLabel?.text {
                
                selectedFilterButtons.append(text)
                presenter.addFilteredMeaning()
                presenter.updatedIsFiltering()
                multiFilteringButton()
                tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func adverbFilterButton(_ sender: Any) {
        
        if adverbFilterButton.isSelected {
            
            adverbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.updatedIsFiltering()
            clearAllFilter()
            presenter.removeFilteredMeaning("adverb")
            tableView.reloadData()
            
            if selectedFilterButtons.isEmpty {
                cancelFilterButton.isHidden = true
            }
            
        } else {
            cancelFilterButton.isHidden = false
            adverbFilterButton.isSelected = true
            
            if let text = adverbFilterButton.titleLabel?.text {
                
                self.selectedFilterButtons.append(text)
                presenter.addFilteredMeaning()
                presenter.updatedIsFiltering()
                multiFilteringButton()
                tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func playAudioButton(_ sender: Any) {
        presenter.playAudio()
    }
    
    func multiFilteringButton() {
        
        if presenter.getIsFiltering() && selectedFilterButtons.count >= 2 {
            
            switch (selectedFilterButtons[1].lowercased()) {
                
            case "noun":
                
                nounFilterButton.isHidden = true
                
                if selectedFilterButtons[0].lowercased().contains("adjective")
                        && selectedFilterButtons[0].lowercased().contains("verb")
                    && selectedFilterButtons[0].lowercased().contains("adverb") {
                    
                    if let spaceIndex = selectedFilterButtons[0].lowercased().firstIndex(of: " ") {
                      
                        let type = selectedFilterButtons[0].lowercased()[..<spaceIndex]
                     
                        if type == "adjective"{
                            adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "verb" {
                            verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "adverb" {
                            adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        }
                    }
                    
                } else if selectedFilterButtons[0].lowercased() == "verb"
                    || selectedFilterButtons[0].lowercased() == "adjective / verb"
                    || selectedFilterButtons[0].lowercased() == "verb / adjective"
                    || selectedFilterButtons[0].lowercased() == "verb / adverb"
                    || selectedFilterButtons[0].lowercased() == "adverb / verb"
                    || selectedFilterButtons[0].lowercased() == "adjective / adverb"
                    || selectedFilterButtons[0].lowercased() == "adverb / adjective" {
                    
                    if selectedFilterButtons[0].lowercased() == "adjective / verb" || selectedFilterButtons[0].lowercased() == "adjective / adverb" {
                        adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "verb / adjective" || selectedFilterButtons[0].lowercased() == "verb / adverb"{
                        verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "adverb / verb" || selectedFilterButtons[0].lowercased() == "adverb / adjective" {
                        adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else {
                        verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    }
                    
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Noun")
             
                } else if selectedFilterButtons[0].lowercased() == "adjective" {
                    adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / Noun"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Noun")
               
                } else if selectedFilterButtons[0].lowercased() == "adverb" {
                    adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Noun")
                }
                
            case "verb":
             
                verbFilterButton.isHidden = true
               
                if selectedFilterButtons[0].lowercased().contains("noun")
                        && selectedFilterButtons[0].lowercased().contains("adjective")
                    && selectedFilterButtons[0].lowercased().contains("adverb") {
                 
                    if let spaceIndex = selectedFilterButtons[0].lowercased().firstIndex(of: " ") {
                        let type = selectedFilterButtons[0].lowercased()[..<spaceIndex]
                        if type == "noun"{
                            nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "adjective" {
                            adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "adverb" {
                            adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        }
                    }
                    
                } else if selectedFilterButtons[0].lowercased() == "noun"
                    || selectedFilterButtons[0].lowercased() == "noun / adjective"
                    || selectedFilterButtons[0].lowercased() == "adjective / noun"
                    || selectedFilterButtons[0].lowercased() == "adjective / adverb"
                    || selectedFilterButtons[0].lowercased() == "adverb / adjective"
                    || selectedFilterButtons[0].lowercased() == "noun / adverb"
                    || selectedFilterButtons[0].lowercased() == "adverb / noun" {
                    
                    if selectedFilterButtons[0].lowercased() == "noun / adjective" || selectedFilterButtons[0].lowercased() == "noun / adverb" {
                        nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "adjective / noun" || selectedFilterButtons[0].lowercased() == "adjective / adverb"{
                        adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "adverb / adjective" || selectedFilterButtons[0].lowercased() == "adverb / noun" {
                        adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else {
                        nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    }
                    
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Verb")
                   

                } else if selectedFilterButtons[0].lowercased() == "adjective" {
             
                    adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Verb")
             
                } else if selectedFilterButtons[0].lowercased() == "adverb" {
             
                    adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Verb")
                }
                
            case "adjective":
         
                adjectiveFilterButton.isHidden = true
          
                if selectedFilterButtons[0].lowercased().contains("noun")
                        && selectedFilterButtons[0].contains("Verb")
                    && selectedFilterButtons[0].contains("Adverb") {
            
                    if let spaceIndex = selectedFilterButtons[0].lowercased().firstIndex(of: " ") {
                   
                        let type = selectedFilterButtons[0].lowercased()[..<spaceIndex]
              
                        if type == "noun"{
                            nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "verb" {
                            verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "adverb" {
                            adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        }
                    }
                    
                } else if selectedFilterButtons[0].lowercased() == "verb"
                    || selectedFilterButtons[0].lowercased() == "noun / verb"
                    || selectedFilterButtons[0].lowercased() == "verb / noun"
                    || selectedFilterButtons[0].lowercased() == "verb / adverb"
                    || selectedFilterButtons[0].lowercased() == "adverb / verb"
                    || selectedFilterButtons[0].lowercased() == "noun / adverb"
                    || selectedFilterButtons[0].lowercased() == "adverb / noun" {
                    
                    if selectedFilterButtons[0].lowercased() == "noun / verb" || selectedFilterButtons[0].lowercased() == "noun / adverb" {
                        nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "verb / noun" || selectedFilterButtons[0].lowercased() == "verb / adverb"{
                        verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "adverb / verb" || selectedFilterButtons[0].lowercased() == "adverb / noun" {
                        adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else {
                        verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    }
                    
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Adjective")
                    
                    
                } else if selectedFilterButtons[0].lowercased() == "noun" {
                    
                    nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Adjective")
                    
                } else if selectedFilterButtons[0].lowercased() == "adverb" {
                    
                    adverbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Adjective")
                }
                
            case "adverb":
           
                adverbFilterButton.isHidden = true
           
                if selectedFilterButtons[0].lowercased().contains("noun")
                        && selectedFilterButtons[0].lowercased().contains("verb")
                    && selectedFilterButtons[0].lowercased().contains("adjective") {
            
                    if let spaceIndex = selectedFilterButtons[0].lowercased().firstIndex(of: " ") {
            
                        let type = selectedFilterButtons[0].lowercased()[..<spaceIndex]
             
                        if type == "noun"{
                            nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "verb" {
                            verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        } else if type == "adjective" {
                            adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                        }
                    }
                    
                } else if selectedFilterButtons[0].lowercased() == "verb"
                        || selectedFilterButtons[0].lowercased().contains("noun / verb")
                        || selectedFilterButtons[0].lowercased().contains("verb / noun")
                        || selectedFilterButtons[0].lowercased().contains("verb / adjective")
                        || selectedFilterButtons[0].lowercased().contains("adjective / verb")
                        || selectedFilterButtons[0].lowercased().contains("noun / adjective")
                        || selectedFilterButtons[0].lowercased().contains("adjective / noun") {
                    
                    if selectedFilterButtons[0].lowercased() == "noun / verb" || selectedFilterButtons[0].lowercased() == "noun / adjective" {
                        nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "verb / noun" || selectedFilterButtons[0].lowercased() == "verb / adjective"{
                        verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else if selectedFilterButtons[0].lowercased() == "adjective / verb" || selectedFilterButtons[0].lowercased() == "adjective / noun" {
                        adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    } else {
                        verbFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    }
                    
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Adverb")
                    
                } else if selectedFilterButtons[0].lowercased() == "noun" {
           
                    nounFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Adverb")
             
                } else if selectedFilterButtons[0].lowercased() == "adjective" {
              
                    adjectiveFilterButton.titleLabel?.text = "\(selectedFilterButtons[0]) / \(selectedFilterButtons[1])"
                    selectedFilterButtons.remove(at: 1)
                    selectedFilterButtons[0] = ("\(selectedFilterButtons[0]) / Adverb")
                }
                
            default:
                break
            }
            
            
            
        } else {
            
        }
        
    }
    
}

extension WordDetailViewController: WordDetailViewControllerProtocol {
    
    func setWordTitle(_ text: String) {
        let capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.wordTitleLabel.text = capitalizedText
    }
    
    func setPhoneticLabel(_ text: String) {
        self.phoneticLabel.text = text
    }
    
    func showLoadingView() {
        showLoading()
    }
    
    func hideLoadingView() {
        hideLoading()
    }
    
    func setupTableView() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(cellType: FooterCell.self)
        self.tableView.register(cellType: WordCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showNotFound() {
        let alert = UIAlertController(title: "Sorry", message: "Word Could Not Be Found", preferredStyle: .alert)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 270, height: 200))
        imageView.image = UIImage(named: "notFoundImage2")
        imageView.contentMode = .scaleAspectFit
        
        alert.view.addSubview(imageView)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
            
            alert.view.heightAnchor.constraint(equalToConstant: 400).isActive = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor).isActive = true
            imageView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 270).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
    }
    
    func getSelectedFilter() -> [String] {
        return self.selectedFilterButtons
    }
    
}

extension WordDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.getIsFiltering() {
            return presenter.getFilteredMeanings().count+1
        }
        return presenter.numberOfItems()+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell: UITableViewCell
     
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
      
            let footerCell = tableView.dequeueCell(with: FooterCell.self, for: indexPath)
       
            if let synonyms = presenter.getSynonyms() {
                footerCell.footerCellPresenter = FooterCellPresenter(view: footerCell, synonyms: synonyms)
                self.tableView.rowHeight = 150
            }
        
            footerCell.router = presenter.getRouter()
            cell = footerCell
            
        } else {
       
            let wordCell = tableView.dequeueCell(with: WordCell.self, for: indexPath)
        
            if presenter.getIsFiltering() {
       
                if let filteredWord = presenter.filteredMeanings(indexPath.row) {
        
                    if filteredWord.newExample == nil || filteredWord.newExample == "" {
                   
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: filteredWord, haveExample: false)
                        self.tableView.rowHeight = 110
              
                    } else {
                 
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: filteredWord, haveExample: true)
                        self.tableView.rowHeight = 130
                        
                    }
                }
            } else {
           
                if let word = presenter.newWord(indexPath.row) {
            
                    if word.newExample == nil || word.newExample == "" {
              
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: word, haveExample: false)
                        self.tableView.rowHeight = 110
                        
                    } else {
               
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: word, haveExample: true)
                        self.tableView.rowHeight = 130
                        
                    }
                }
            }
            cell = wordCell
            
        }
        
        return cell
        
    }
    
    
}


extension WordDetailViewController {
   
    private func setAccessibilityIdentifiers() {
    
        wordTitleLabel.accessibilityIdentifier = "wordTitleLabel"
        phoneticLabel.accessibilityIdentifier = "accessibilityIdentifier"
        cancelFilterButton.accessibilityIdentifier = "cancelFilterButton"
        nounFilterButton.accessibilityIdentifier = "nounFilterButton"
        verbFilterButton.accessibilityIdentifier = "verbFilterButton"
        adjectiveFilterButton.accessibilityIdentifier = "adjectiveFilterButton"
        adverbFilterButton.accessibilityIdentifier = "adverbFilterButton"
        playAudioButton.accessibilityIdentifier = "playAudioButton"
  
    }

}
