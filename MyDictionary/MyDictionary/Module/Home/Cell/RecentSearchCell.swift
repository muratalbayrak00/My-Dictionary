//
//  RecentSearchCell.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import UIKit

protocol RecentSearchCellProtocol: AnyObject {
    func setSearchIcon(_ image: UIImage)
    func setWordLabel(_ text: String)
    func setArrowIcon(_ image: UIImage)
}

class RecentSearchCell: UITableViewCell {

    @IBOutlet weak var searchIcon: UIImageView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var arrowLabel: UIImageView!
    
    var cellPresenter: RecentSearchCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // TODO: Table view yuklenirken buraya bir anamasyon gibi bir seyler ekleyebilir yukaridan asagiya sirali bir anamasyon olabilir 
    }

}

extension RecentSearchCell: RecentSearchCellProtocol {
    
    func setSearchIcon(_ image: UIImage) {
        self.searchIcon.image = image // TODO: Burayi main tread e de alabilirsin duruma gore degistirirsin
    }
    
    func setWordLabel(_ text: String) {
        self.wordLabel.text = text
    }
    
    func setArrowIcon(_ image: UIImage) {
        self.arrowLabel.image = image
    }
    
}
