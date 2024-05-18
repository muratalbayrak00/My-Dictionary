//
//  SplashInteractor.swift
//  MyDictionary
//
//  Created by murat albayrak on 18.05.2024.
//

import Foundation
import DictionaryApi

protocol SplashInteractorProtocol: AnyObject {
    func checkInternetConnection()
}

//Sonucu presenter a gönderir
protocol SplashInteractorOutputProtocol: AnyObject {
    func internetConnection(status: Bool)
}

final class SplashInteractor {
    var output: SplashInteractorOutputProtocol?
}

extension SplashInteractor: SplashInteractorProtocol {
    
    func checkInternetConnection() {
        let internerStatus = API.shared.isConnectedToInternet()
        self.output?.internetConnection(status: internerStatus)
    }
    
}
