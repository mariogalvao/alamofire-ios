//
//  ViewController.swift
//  URLSession
//
//  Created by Mário Galvao on 25/09/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

protocol ViewControllerProtocol: class {
    
    func alert(title: String, message: String)
    func alertError(_ error: APIError)
    
}

extension ViewController: ViewControllerProtocol {
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func alertError(_ error: APIError) {
        let alert = UIAlertController(title: "Erro", message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
