//
//  BaseViewController.swift
//  MyDictionary
//
//  Created by murat albayrak on 18.05.2024.
//

import UIKit

class BaseViewController: UIViewController, LoadingShowable {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
