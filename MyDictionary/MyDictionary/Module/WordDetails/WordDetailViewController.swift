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
    func setWordTitle(_ text: String)
    func setPhoneticLabel(_ text: String)
}

class WordDetailViewController: BaseViewController{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var wordTitleLabel: UILabel!
    @IBOutlet weak var phoneticLabel: UILabel!
    
    var presenter: WordDetailPresenterProtocol!
    var searchText: String = ""
    var source: WordsData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: WordCell.self)
        presenter.viewDidLoad()
    }
    

}

extension WordDetailViewController: WordDetailViewControllerProtocol {

    func setTableViewHeight() {
        self.tableView.rowHeight = 150
    }
    
    func setWordTitle(_ text: String) {
        var capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        wordTitleLabel.text = capitalizedText
    }
    
    func setPhoneticLabel(_ text: String) {
        phoneticLabel.text = text
    }
    
}

extension WordDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(with: WordCell.self, for: indexPath)
        
        if let word = presenter.word(indexPath.row) {
            cell.cellPresenter = WordCellPresenter(view: cell, word: word)
        }
        
        return cell
    }
    
    
}
