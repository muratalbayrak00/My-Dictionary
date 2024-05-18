//
//  RecentSearchCellPresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 19.05.2024.
//

import Foundation
import UIKit

protocol RecentSearchCellPresenterProtocol: AnyObject {
    func load()
}

final class RecentSearchCellPresenter {
    
    weak var view: RecentSearchCellProtocol?
    private let recentWords: String
    
    init(
        view: RecentSearchCellProtocol? = nil,
        recentWords: String
    ) {
        self.view = view
        self.recentWords = recentWords
    }
    
}

extension RecentSearchCellPresenter: RecentSearchCellPresenterProtocol {
    
    func load() {
        view?.setSearchIcon(UIImage(systemName: "doc.text.magnifyingglass") ?? UIImage(named: "defaultIcon")! )
        view?.setWordLabel(recentWords)
        view?.setArrowIcon(UIImage(systemName: "arrow.right") ?? UIImage(named: "defaultIcon")!)
    }
    
}
