//
//  LoginVC.swift
//  JoyBookDirectory
//
//  Created by Aent Bhone on 28/05/2024.
//

import UIKit

class LoginVC: BaseVC, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: SecureTextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton){
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
        
        if let userData = DataHelper.shared.fetchData(for: username){
            if userData.password == password{
                self.showToastAlert(title: "Login successful.", message: "", alertStyle: .alert) {
                    LocalStorage.shared.setUsername(username)
                    LocalStorage.shared.setIsLoggedIn(true)
                    self.toTabBarVC()
                }
            }else{
                self.showToastAlert(title: "Login failed. Incorrect password.", message: "", alertStyle: .alert)
            }
        } else {
            self.showToastAlert(title: "Login failed. Username not found.", message: "", alertStyle: .alert)
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton){
        toRegisterVC()
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
