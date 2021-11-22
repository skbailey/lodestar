//
//  LoginViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func login(_ sender: UIButton) {
        self.emailErrorLabel.text = nil
        self.passwordErrorLabel.text = nil
        
        guard let email = emailTextField.text, email != "" else {
            emailErrorLabel.text = "missing email for login"
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            passwordErrorLabel.text = "missing password for login"
            return
        }
        
        CloudService.shared.login(email: email, password: password) { [weak self] in
            DispatchQueue.main.async {
                self?.emailTextField.text = nil
                self?.emailErrorLabel.text = nil
                self?.passwordTextField.text = nil
                self?.passwordErrorLabel.text = nil
                
                self?.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
