//
//  UserDefaultsViewController.swift
//  Module 14
//
//  Created by Avicus Delacroix on 01.06.2022.
//

import UIKit

class UserDefaultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // when the view loads, load the UserDefaults
        firstNameTextField.text = Persistence.shared.firstName
        lastNameTextField.text = Persistence.shared.lastName
    }
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // when text fields change, record the new value to UserDefaults
    @IBAction func firstNameDidSet(_ sender: Any) {
        Persistence.shared.firstName = firstNameTextField.text
    }
    @IBAction func lastNameDidSet(_ sender: Any) {
        Persistence.shared.lastName = lastNameTextField.text
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        view.endEditing(true)
    }
}
