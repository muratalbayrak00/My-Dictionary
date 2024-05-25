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
    @IBOutlet weak var arrowIcon: UIImageView!
    
    var cellPresenter: RecentSearchCellPresenterProtocol! {
        didSet{
            cellPresenter.load()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

extension RecentSearchCell: RecentSearchCellProtocol {
    
    func setSearchIcon(_ image: UIImage) {
        self.searchIcon.image = image
    }
    
    func setWordLabel(_ text: String) {
        self.wordLabel.text = text
    }
    
    func setArrowIcon(_ image: UIImage) {
        self.arrowIcon.image = image
    }
    
}
