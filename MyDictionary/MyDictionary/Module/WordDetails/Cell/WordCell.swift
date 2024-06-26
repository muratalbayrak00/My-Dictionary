//
//  WordCell.swift
//  MyDictionary
//
//  Created by murat albayrak on 20.05.2024.
//

import UIKit

protocol WordCellProtocol: AnyObject {
    
    func setWordType(_ text: String)
    func setWordMeaning(_ text: String)
    func setExampleLabel(_ text: String)
    func setExampleSentence(_ text: String)
    func getHaveExample() -> Bool
    func setHiddenExample(_ status: Bool)
    
}

class WordCell: UITableViewCell {

    @IBOutlet weak var wordMeaningLabel: UILabel!
    @IBOutlet weak var wordTypeLabel: UILabel!
    @IBOutlet weak var exampleSentenceLabel: UILabel!
    @IBOutlet weak var exampleTextLabel: UILabel!
    
    var cellPresenter: WordCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
}

extension WordCell: WordCellProtocol {
    
    func setHiddenExample(_ status: Bool) {
        self.exampleTextLabel.isHidden = status
        self.exampleSentenceLabel.isHidden = status
    }
    
    func getHaveExample() -> Bool {
        return cellPresenter.getHaveStatus()
    }
    
    func setWordType(_ text: String) {
     
        wordTypeLabel.font = UIFont.boldSystemFont(ofSize: 19)
        wordTypeLabel.font = UIFont.italicSystemFont(ofSize: 19)
        let capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.wordTypeLabel.text = capitalizedText

    }
    
    func setWordMeaning(_ text: String) {
    
        let capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.wordMeaningLabel.text = capitalizedText
    }
    
    func setExampleLabel(_ text: String) {
     
        let capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.exampleTextLabel.text = capitalizedText

    }
    
    func setExampleSentence(_ text: String) {
        
        let capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
     
        self.exampleSentenceLabel.text = capitalizedText
     
        if text.isEmpty {
            exampleSentenceLabel.isHidden = true
            exampleTextLabel.isHidden = true
        } else {
            exampleSentenceLabel.isHidden = false
            exampleTextLabel.isHidden = false
        }
        
    }
    
}
