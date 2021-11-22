//
//  SignupViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    @IBOutlet weak var passwordConfirmErrorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        emailErrorLabel.text = nil
        passwordErrorLabel.text = nil
        passwordConfirmErrorLabel.text = nil
        
        guard let email = emailTextField.text, email != "" else {
            emailErrorLabel.text = "missing email for sign up"
            return
        }
        
        guard let password = passwordTextField.text, password != "" else {
            passwordErrorLabel.text = "missing password for signup"
            return
        }
        
        guard let passwordConfirm = passwordConfirmTextField.text, passwordConfirm != "" else {
            passwordConfirmErrorLabel.text = "missing password confirmation for signup"
            return
        }
        
        if password != passwordConfirm {
            passwordConfirmErrorLabel.text = "password and confirmation do not match"
            return
        }
        
        CloudService.shared.signUp(email: email, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.showAlert(message: error.errorDescription)
                    return
                case .success:
                    print("sign up success")
                }
                
                self?.performSegue(withIdentifier: "confirm", sender: self)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Sign Up Failed", message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            //OK Action
        })
        
        self.present(alert, animated: true, completion: nil)
    }
}
