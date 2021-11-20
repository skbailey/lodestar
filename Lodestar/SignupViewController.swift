//
//  SignupViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        guard let mobile = mobileTextField.text else {
            print("missing mobile number for sign up")
            return
        }
        
        guard let password = passwordTextField.text else {
            print("missing password for signup")
            return
        }
        
        CloudService.shared.signUp(email: mobile, password: password) { [weak self] in
            DispatchQueue.main.async {
                self?.performSegue(withIdentifier: "confirm", sender: self)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
