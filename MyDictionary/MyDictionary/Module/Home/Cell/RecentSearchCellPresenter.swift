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
    private let recentWord: String
    
    init(
        view: RecentSearchCellProtocol? = nil,
        recentWord: String
    ) {
        self.view = view
        self.recentWord = recentWord
    }
    
}

extension RecentSearchCellPresenter: RecentSearchCellPresenterProtocol {
    
    func load() {
        view?.setSearchIcon(UIImage(systemName: "magnifyingglass") ?? UIImage(named: "defaultIcon")! )        
        view?.setWordLabel("   \(recentWord.capitalizingFirstLetter())")
        view?.setArrowIcon(UIImage(systemName: "arrow.right") ?? UIImage(named: "defaultIcon")!)
    }
    
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
