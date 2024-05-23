//
//  FooterCellPresenter.swift
//  MyDictionary
//
//  Created by murat albayrak on 24.05.2024.
//

import Foundation

protocol FooterCellPresenterProtocol: AnyObject {
    func load()
}

final class FooterCellPresenter {
    
    weak var view: FooterCellProtocol?
    private var sysnonyms: [String]
    
    init(view: FooterCellProtocol? = nil, sysnonyms: [String]) {
        self.view = view
        self.sysnonyms = sysnonyms
    }
    
}

extension FooterCellPresenter: FooterCellPresenterProtocol {
 
    func load() {
        
        view?.setSysonymButton1(self.sysnonyms[0])
        view?.setSysonymButton2(self.sysnonyms[1])
        view?.setSysonymButton3(self.sysnonyms[2])
        view?.setSysonymButton4(self.sysnonyms[3])
        view?.setSysonymButton5(self.sysnonyms[4])
        
    }
    
}
