//
//  WordDetailViewController.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import UIKit
import DictionaryApi

protocol WordDetailViewControllerProtocol: AnyObject {
    func setTestLabel(_ text: String)
}

class WordDetailViewController: BaseViewController {

    var presenter: WordDetailPresenterProtocol!
    var source: WordsData?
    
    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    

}

extension WordDetailViewController: WordDetailViewControllerProtocol {
    
    func setTestLabel(_ text: String) {
        DispatchQueue.main.async {
            self.testLabel.text = text
        }
    }
    
    
}
