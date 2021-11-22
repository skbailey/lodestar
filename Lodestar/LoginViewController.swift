//
//  LoginViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func unwindToLogin(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let email = emailTextField.text else {
            print("missing email for login")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("missing password for login")
            return
        }
        
        CloudService.shared.login(email: email, password: password) { [weak self] in
            DispatchQueue.main.async {
                self?.emailTextField.text = nil
                self?.passwordTextField.text = nil
                
                self?.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
