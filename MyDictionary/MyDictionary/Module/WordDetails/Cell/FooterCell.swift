//
//  FooterCell.swift
//  MyDictionary
//
//  Created by murat albayrak on 24.05.2024.
//

import UIKit

protocol FooterCellProtocol: AnyObject {
    func setSysonymButton1(_ text: String)
    func setSysonymButton2(_ text: String)
    func setSysonymButton3(_ text: String)
    func setSysonymButton4(_ text: String)
    func setSysonymButton5(_ text: String)
    
}
class FooterCell: UITableViewCell {

    @IBOutlet weak var sysonymButton1: UIButton!
    @IBOutlet weak var sysonymButton2: UIButton!
    @IBOutlet weak var sysonymButton3: UIButton!
    @IBOutlet weak var sysonymButton4: UIButton!
    @IBOutlet weak var sysonymButton5: UIButton!
    
    var footerCellPresenter: FooterCellPresenterProtocol! {
        didSet{
            footerCellPresenter.load()
        }
    }
    
    var router: WordDetailRouterProtocol!

    override func awakeFromNib() {
        super.awakeFromNib()
                
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5) {
            self.transform = CGAffineTransform.identity
        }
    }


    
    @IBAction func sysonymButton1(_ sender: Any) {
        
        if let text = sysonymButton1.titleLabel?.text {
            router.navigate(.synonym(text))
            print(text)
        }
    }
    
    @IBAction func sysonymButton2(_ sender: Any) {
        
        if let text = sysonymButton2.titleLabel?.text {
            router.navigate(.synonym(text))
        }
    }
    
    @IBAction func sysonymButton3(_ sender: Any) {
        
        if let text = sysonymButton3.titleLabel?.text {
            router.navigate(.synonym(text))
        }
    }
    
    @IBAction func sysonymButton4(_ sender: Any) {
        
        if let text = sysonymButton4.titleLabel?.text {
            router.navigate(.synonym(text))
        }
    }
    
    @IBAction func sysonymButton5(_ sender: Any) {
        if let text = sysonymButton5.titleLabel?.text {
            router.navigate(.synonym(text))
        }
    }
    
}

extension FooterCell: FooterCellProtocol {
    
    func setSysonymButton1(_ text: String) {
        sysonymButton1.titleLabel?.text = text
    }
    
    func setSysonymButton2(_ text: String) {
        sysonymButton2.titleLabel?.text = text
    }
    
    func setSysonymButton3(_ text: String) {
        sysonymButton3.titleLabel?.text = text
    }
    
    func setSysonymButton4(_ text: String) {
        sysonymButton4.titleLabel?.text = text
    }
    
    func setSysonymButton5(_ text: String) {
        sysonymButton5.titleLabel?.text = text
    }
    
    
}
