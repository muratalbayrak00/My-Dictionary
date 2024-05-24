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
        tableView.reloadData()
        
        cancelFilterButton.isHidden = true
        setButtonContraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //presenter.viewWillAppear()
        
    }
    
    func hiddenFilterButtons(_ wordTypes: [String]) {
        DispatchQueue.main.async {
            if !self.presenter.getWordTypes().contains(where: { $0 == "noun" }) {
                self.nounFilterButton.isHidden = true
            }
            if !self.presenter.getWordTypes().contains(where: { $0 == "verb" }) {

                self.verbFilterButton.isHidden = true
            }
            if !self.presenter.getWordTypes().contains(where: { $0 == "adjective" }) {

                self.adjectiveFilterButton.isHidden = true
            }
            if !self.presenter.getWordTypes().contains(where: { $0 == "adverb" }) {

                self.adverbFilterButton.isHidden = true
            }
        }

    }
    
    @IBAction func cancelFilterButton(_ sender: Any) {
        selectedFilterButtons.removeAll()
        presenter.updatedIsFiltering()
        tableView.reloadData()
        setButtonsNonSelected()
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
            tableView.reloadData()
            presenter.removeFilteredMeaning("noun")
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
                tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func adverbFilterButton(_ sender: Any) {
        
        
        if adverbFilterButton.isSelected {
            adverbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.updatedIsFiltering()
            tableView.reloadData()
            presenter.removeFilteredMeaning("adverb")
            
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
                tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func playAudioButton(_ sender: Any) {
        presenter.playAudio()
    }
    
    func setButtonContraints() {
        
        //nounFilterButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //button2.widthAnchor.constraint(equalToConstant: 100).isActive = true
       // button3.widthAnchor.constraint(equalToConstant: 100).isActive = true
        //button4.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }
    
    
}

extension WordDetailViewController: WordDetailViewControllerProtocol {
    
    func setTableViewHeight() {
       // self.tableView.rowHeight = UITableView.automaticDimension
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
            //print("getFilteredMeanings Count\(presenter.getFilteredMeanings().count)")
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
                      //  tableView.reloadRows(at: [indexPath], with: .automatic)
                        //self.tableView.reloadData()
                    } else {
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: filteredWord, haveExample: true)
                        self.tableView.rowHeight = 130
                       // tableView.reloadRows(at: [indexPath], with: .automatic)

                        //self.tableView.reloadData()
                    }
                }
            } else {
                if let word = presenter.newWord(indexPath.row) {
                    if word.newExample == nil || word.newExample == "" {
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: word, haveExample: false)
                        self.tableView.rowHeight = 110
                       // tableView.reloadRows(at: [indexPath], with: .automatic)

                        //self.tableView.reloadData()
                    } else {
                        wordCell.cellPresenter = WordCellPresenter(view: wordCell, word: word, haveExample: true)
                        self.tableView.rowHeight = 130
                       // tableView.reloadRows(at: [indexPath], with: .automatic)

                        //self.tableView.reloadData()
                    }
                }
            }
            cell = wordCell
            
        }
        
        return cell
        
        //        let cell = tableView.dequeueCell(with: WordCell.self, for: indexPath)
        //
        //        if presenter.getIsFiltering() {
        //            if let filteredWord = presenter.filteredMeanings(indexPath.row) {
        //                cell.cellPresenter = WordCellPresenter(view: cell, word: filteredWord)
        //            }
        //        } else {
        //            if let word = presenter.newWord(indexPath.row) {
        //                cell.cellPresenter = WordCellPresenter(view: cell, word: word)
        //            }
        //        }
        //
        //        return cell
    }
    
    
    
    
    
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    //        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
    //            // Son hücreye ulaşıldığında
    //            if let footerCell = cell as? FooterCell {
    //                // Eğer hücre bir FooterCell ise
    //                if let synonyms = presenter.getSynonyms() {
    //                    // FooterCell'in içeriğini ayarlayın
    //                    footerCell.footerCellPresenter = FooterCellPresenter(view: footerCell, sysnonyms: synonyms)
    //                }
    //            }
    //        }
    //        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
    //            // Son hücreye ulaşıldığında
    //            let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FooterCell") as? FooterCell
    //            if let synonyms = presenter.getSynonyms() {
    //                // FooterCell'in içeriğini ayarlayın
    //                footerView?.footerCellPresenter = FooterCellPresenter(view: footerView, sysnonyms: synonyms)
    //                tableView.tableFooterView = footerView
    //            }
    //        }
    // }
    
}


//        let lastRowIndex = tableView.numberOfRows(inSection: indexPath.section) - 1
//        if indexPath.row == lastRowIndex {
//            let cell = tableView.dequeueCell(with: FooterCell.self, for: indexPath)
//            print("********************************")
//            if let synonyms = presenter.getSynonyms() {
//                cell.footerCellPresenter = FooterCellPresenter(view: cell, sysnonyms: synonyms)
//            }
//        }

