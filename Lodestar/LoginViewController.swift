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
        
        CloudService.shared.login(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                self?.emailTextField.text = nil
                self?.emailErrorLabel.text = nil
                self?.passwordTextField.text = nil
                self?.passwordErrorLabel.text = nil
                
                switch result {
                case .failure(let error):
                    print("An error occurred while registering a user \(error)")
                    self?.showAlert(message: error.errorDescription)
                    return
                case .success(let loginResult):
                    debugPrint(loginResult)
                }
                
                self?.performSegue(withIdentifier: "login", sender: self)
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Sign In Failed", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            //OK Action
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
