//
//  RegisterVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class RegisterVC: BaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: SecureTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton){
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        guard isValidUsername(username) else {
            print("Invalid username.")
            self.showMessageAlert(title: "Invalid username. Username must not contain spaces and only include alphanumeric characters and underscores.(Eg: Eric_90)", message: "", showOK: true)
            return
        }
        
        guard !username.isEmpty, !password.isEmpty else {
            print("Username and password cannot be empty.")
            self.showToastAlert(title: "Username and password cannot be empty.", message: "", alertStyle: .alert)
            return
        }
        
        if DataHelper.shared.saveData(username: username, password: password) {
            self.showToastAlert(title: "User registered successfully.", message: "", alertStyle: .alert) {
                self.toLoginInVC()
            }
        } else {
            self.showToastAlert(title: "Username already exists. Please choose a different username.", message: "", alertStyle: .alert)
        }
        
//        DataHelper.shared.saveData(username: username, password: password)
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == usernameTextField {
            let allowedCharacters = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "_"))
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
