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
    
    func setHiddenButton1(_ status: Bool)
    func setHiddenButton2(_ status: Bool)
    func setHiddenButton3(_ status: Bool)
    func setHiddenButton4(_ status: Bool)
    func setHiddenButton5(_ status: Bool)
    func setDisableButton1(_ status: Bool)
    
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
        sysonymButton1.titleLabel?.textAlignment = .center
    }
    
    func setSysonymButton2(_ text: String) {
        sysonymButton2.titleLabel?.text = text
        sysonymButton2.titleLabel?.textAlignment = .center
    }
    
    func setSysonymButton3(_ text: String) {
        sysonymButton3.titleLabel?.text = text
        sysonymButton3.titleLabel?.textAlignment = .center
    }
    
    func setSysonymButton4(_ text: String) {
        sysonymButton4.titleLabel?.text = text
        sysonymButton4.titleLabel?.textAlignment = .center
    }
    
    func setSysonymButton5(_ text: String) {
        sysonymButton5.titleLabel?.text = text
        sysonymButton5.titleLabel?.textAlignment = .center
    }
    
    func setHiddenButton1(_ status: Bool) {
        sysonymButton1.isHidden = status
    }
    
    func setHiddenButton2(_ status: Bool) {
        sysonymButton2.isHidden = status
    }
    
    func setHiddenButton3(_ status: Bool) {
        sysonymButton3.isHidden = status
    }
    
    func setHiddenButton4(_ status: Bool) {
        sysonymButton4.isHidden = status
    }
    
    func setHiddenButton5(_ status: Bool) {
        sysonymButton5.isHidden = status
    }
    
    func setDisableButton1(_ status: Bool) {
        sysonymButton1.isUserInteractionEnabled = status
    }
    
 
}
