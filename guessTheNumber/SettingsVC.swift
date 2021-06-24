//
//  SettingsVC.swift
//  guessTheNumber
//
//  Created by Артем Соколовский on 22.06.2021.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var minimumValueTF: UITextField!
    @IBOutlet weak var maximumValueTF: UITextField!
    
    var randomNumber: RandomNumber!
    var delegate: SettingsVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = NSLocalizedString("Range", comment: "")
        minimumValueTF.text = String(randomNumber.minimumValue)
        maximumValueTF.text = String(randomNumber.maximumValue)
        minimumValueTF.delegate = self
        maximumValueTF.delegate = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Int(newValue) else { return }
        
        if textField == minimumValueTF {
            randomNumber.minimumValue = numberValue
        } else {
            randomNumber.maximumValue = numberValue
        }
    }
}
