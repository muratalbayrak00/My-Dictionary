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
        
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
        }
    }
    
}

extension WordCell: WordCellProtocol {
    
    func setWordType(_ text: String) {
        var capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.wordTypeLabel.text = capitalizedText
    }
    
    func setWordMeaning(_ text: String) {
        var capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.wordMeaningLabel.text = capitalizedText
    }
    
    func setExampleLabel(_ text: String) {
        var capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.exampleTextLabel.text = capitalizedText
    }
    
    func setExampleSentence(_ text: String) {
        var capitalizedText = text.prefix(1).uppercased() + text.dropFirst()
        self.exampleSentenceLabel.text = capitalizedText
    }
    
}
