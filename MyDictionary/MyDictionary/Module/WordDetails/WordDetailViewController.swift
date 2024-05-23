//
//  WordDetailViewController.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import UIKit
import DictionaryApi

protocol WordDetailViewControllerProtocol: AnyObject {
    func setTableViewHeight()
    func setupTableView()
    func reloadData()
    func setWordTitle(_ text: String)
    func setPhoneticLabel(_ text: String)
    func showLoadingView()
    func hideLoadingView()
    //func getSource() -> [WordsData]?
}

class WordDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    
    var selectedFilterButtons: [String] = []
    var presenter: WordDetailPresenterProtocol!
    var searchText: String = ""
    //var source: [WordsData]?
    
    
    @IBOutlet weak var cancelFilterButton: UIButton!
    
    @IBOutlet weak var nounFilterButton: UIButton!
    
    @IBOutlet weak var verbFilterButton: UIButton!
    
    @IBOutlet weak var adjectiveFilterButton: UIButton!
    
    @IBOutlet weak var adverbFilterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        cancelFilterButton.isHidden = true
        
    }
    
    @IBAction func cancelFilterButton(_ sender: Any) {
        
    }
    
    @IBAction func nounFilterButton(_ sender: Any) {
        // TODO: buradaki if let yapisini degistir belki en basa geleblir gibi duzelt sonradan
        
        if nounFilterButton.isSelected {
            nounFilterButton.isSelected = false
           // cancelFilterButton.isHidden = true
            selectedFilterButtons.removeLast()
            if selectedFilterButtons.count == 0 {
                cancelFilterButton.isHidden = true
            }
        } else {
            nounFilterButton.isSelected = true
            cancelFilterButton.isHidden = false
            if let text = nounFilterButton.titleLabel?.text {
                selectedFilterButtons.append(text)
            }

        }
        
        print(selectedFilterButtons)
        
    }
    
    @IBAction func verbFilterButton(_ sender: Any) {
        
        if verbFilterButton.isSelected {
            verbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            if selectedFilterButtons.isEmpty {
                cancelFilterButton.isHidden = true
            }
        } else {
            cancelFilterButton.isHidden = false
            verbFilterButton.isSelected = true
            if let text = verbFilterButton.titleLabel?.text {
                selectedFilterButtons.append(text)
            }
        }
        
        print(selectedFilterButtons)

    }
    
    @IBAction func adjectiveFilterButton(_ sender: Any) {
        
        if adjectiveFilterButton.isSelected {
            adjectiveFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            if selectedFilterButtons.isEmpty {
                cancelFilterButton.isHidden = true
            }
        } else {
            cancelFilterButton.isHidden = false
            adjectiveFilterButton.isSelected = true
            if let text = adjectiveFilterButton.titleLabel?.text {
                selectedFilterButtons.append(text)
            }
        }
        
        print(selectedFilterButtons)

    }
    
    @IBAction func adverbFilterButton(_ sender: Any) {
        
        if adverbFilterButton.isSelected {
            adverbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            if selectedFilterButtons.isEmpty {
                cancelFilterButton.isHidden = true
            }
        } else {
            cancelFilterButton.isHidden = false
            adverbFilterButton.isSelected = true
            if let text = adverbFilterButton.titleLabel?.text {
                selectedFilterButtons.append(text)
            }
        }
        
        print(selectedFilterButtons)

    }
    
    @IBAction func playAudioButton(_ sender: Any) {
        presenter.playAudio()
    }
    
}

extension WordDetailViewController: WordDetailViewControllerProtocol {

    func setTableViewHeight() {
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = 150
    }
    
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
        self.tableView.register(cellType: WordCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
   // func getSource() -> [DictionaryApi.WordsData]? {
        //return source
   // }
    
    
}

extension WordDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
       // presenter.getWord()?.flatMap { $0.meanings ?? [] }.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: WordCell.self, for: indexPath)

  
//        if let word = presenter.word(indexPath.row) {
//            cell.cellPresenter = WordCellPresenter(view: cell, word: word)
//            //cell.cellPresenter.load()
//            // "\(word.meanings.map { "\($0.partOfSpeech): \($0.definitions.first?.definition ?? "") \( $0.definitions.first?.example != nil ? "(\($0.definitions.first?.example ?? ""))" : "")" }".joined(separator: ", "))"
//        }
        
        if let word = presenter.newWord(indexPath.row) {
            cell.cellPresenter = WordCellPresenter(view: cell, word: word)
        }
        
            
        
        return cell
    }
    

    
}
