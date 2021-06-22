//
//  ViewController.swift
//  guessTheNumber
//
//  Created by Артем Соколовский on 21.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textFieldForNumber: UITextField!
    
    private var randomNumber = Int.random(in: 0...100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldForNumber.keyboardType = .numberPad
        
    }
    
    @IBAction func checkValueButton() {
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in }
        
        let abortAction = UIAlertAction(
            title: "Загадать новое число",
            style: .default
        ) { _ in
            self.randomNumber = Int.random(in: 0...100)
        }
        
        if Int(textFieldForNumber.text ?? "") ?? 0 < randomNumber {
            showAlert(
                title: "Ошибка!",
                message: "Мало",
                action: okAction
            )
        } else if Int(textFieldForNumber.text ?? "") ?? 0 > randomNumber {
            showAlert(
                title: "Ошибка!",
                message: "Много",
                action: okAction
            )
        } else {
            showAlert(
                title: "Молодец!",
                message: "Угадал - это \(randomNumber)",
                action: abortAction
            )
        }
    }
    
    @IBAction func showRandomNumber() {
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in }
        showAlert(
            title: "Random Number",
            message: String(randomNumber),
            action: okAction
        )
    }
    
    private func showAlert(title: String, message: String, action: UIAlertAction) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(action)
        present(alert, animated: true)
    }
}

