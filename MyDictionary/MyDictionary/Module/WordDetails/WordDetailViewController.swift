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
        
        cancelFilterButton.isHidden = false
        
    }
    
    @IBAction func cancelFilterButton(_ sender: Any) {
    }
    
    @IBAction func nounFilterButton(_ sender: Any) {
        // TODO: buradaki if let yapisini degistir belki en basa geleblir gibi duzelt sonradan
        
        if nounFilterButton.isSelected {
            nounFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.updatedIsFiltering()
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
            }
        }

    }
    
    @IBAction func verbFilterButton(_ sender: Any) {
        if verbFilterButton.isSelected {
            verbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.removeFilteredMeaning("verb")
            presenter.updatedIsFiltering()
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
            }
        }
    }
    
    @IBAction func adjectiveFilterButton(_ sender: Any) {

        if adjectiveFilterButton.isSelected {
            adjectiveFilterButton.isSelected = false
            
            selectedFilterButtons.removeLast()
            presenter.removeFilteredMeaning("adjective")
            presenter.updatedIsFiltering()
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
            }
        }

    }
    
    @IBAction func adverbFilterButton(_ sender: Any) {
        
        
        if adverbFilterButton.isSelected {
            adverbFilterButton.isSelected = false
            selectedFilterButtons.removeLast()
            presenter.updatedIsFiltering()
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
            }
        }
        
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
    
    func showNotFound() {
        let alert = UIAlertController(title: "Sorry", message: "Word Could Not Found", preferredStyle: .alert)
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.getIsFiltering() {
            //print("getFilteredMeanings Count\(presenter.getFilteredMeanings().count)")
            return presenter.getFilteredMeanings().count
        }
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: WordCell.self, for: indexPath)
        
        if presenter.getIsFiltering() {
            if let filteredWord = presenter.filteredMeanings(indexPath.row) {
                cell.cellPresenter = WordCellPresenter(view: cell, word: filteredWord)
            }
        } else {
            if let word = presenter.newWord(indexPath.row) {
                cell.cellPresenter = WordCellPresenter(view: cell, word: word)
            }
        }
        
        return cell
    }
    
}
