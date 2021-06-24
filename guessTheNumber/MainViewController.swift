//
//  ViewController.swift
//  guessTheNumber
//
//  Created by Артем Соколовский on 21.06.2021.
//

import UIKit

protocol SettingsVCDelegate {
    func setNewValues(min: Int, max: Int)
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var textFieldForNumber: UITextField!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var rangeLabel: UILabel!
    
    private var randomNumber = RandomNumber(minimumValue: 0, maximumValue: 100)
    private var getRandom = 0
    private var stepsCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomNumber.minimumValue = StorageManager.shared.fetch(key: "min")
        randomNumber.maximumValue = StorageManager.shared.fetch(key: "max")
        
        getRandom = randomNumber.randomValue
        
        textFieldForNumber.keyboardType = .numberPad
        
        stepsLabel.text = NSLocalizedString("Number of steps", comment: "") + " \(stepsCounter)"
        rangeLabel.text = NSLocalizedString("Range", comment: "") + " \(randomNumber.minimumValue)...\(randomNumber.maximumValue)"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsVC else { return }
        settingsVC.randomNumber = randomNumber
        settingsVC.delegate = self
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        guard let settingsVC = unwindSegue.source as? SettingsVC else { return }
        
        settingsVC.view.endEditing(true)
        settingsVC.delegate.setNewValues(min: settingsVC.randomNumber.minimumValue, max: settingsVC.randomNumber.maximumValue)
        
        StorageManager.shared.save(number: randomNumber.minimumValue, key: "min")
        StorageManager.shared.save(number: randomNumber.maximumValue, key: "max")
    }
    
    @IBAction func checkValueButton() {
        stepsCounter += 1
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in }
        
        let abortAction = UIAlertAction(
            title: NSLocalizedString("Make a new number", comment: ""),
            style: .default
        ) { _ in
            self.getRandom = self.randomNumber.randomValue
            self.stepsCounter = 0
            self.stepsLabel.text = NSLocalizedString("Number of steps", comment: "")
                + " \(self.stepsCounter)"
        }
        
        if Int(textFieldForNumber.text ?? "") ?? 0 < getRandom {
            showAlert(
                title: NSLocalizedString("Error!", comment: ""),
                message: NSLocalizedString("Few", comment: ""),
                action: okAction
            )
        } else if Int(textFieldForNumber.text ?? "") ?? 0 > getRandom {
            showAlert(
                title: NSLocalizedString("Error!", comment: ""),
                message: NSLocalizedString("Many", comment: ""),
                action: okAction
            )
        } else {
            showAlert(
                title: NSLocalizedString("Congrats!", comment: ""),
                message: NSLocalizedString("You're right", comment: "") + " - \(getRandom)",
                action: abortAction
            )
        }
        
        stepsLabel.text = NSLocalizedString("Number of steps", comment: "") + " \(stepsCounter)"
        
    }
    
    @IBAction func showRandomNumber() {
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { _ in }
        
        showAlert(
            title: NSLocalizedString("Random Number", comment: ""),
            message: String(getRandom),
            action: okAction
        )
    }
    
    @IBAction func getNewRandomNumber() {
        getRandom = randomNumber.randomValue
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

extension MainViewController: SettingsVCDelegate {
    func setNewValues(min: Int, max: Int) {
        randomNumber.minimumValue = min
        randomNumber.maximumValue = max
        rangeLabel.text = NSLocalizedString("Range", comment: "") +
            " \(randomNumber.minimumValue)...\(randomNumber.maximumValue)"
        getRandom = randomNumber.randomValue
    }
}
