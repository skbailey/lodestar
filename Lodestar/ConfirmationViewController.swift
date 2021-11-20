//
//  ConfirmationViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class ConfirmationViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var confirmationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let oneTimePass = confirmationTextField.text else {
            print("missing one time pass code to confirm sign up")
            return false
        }
        
        CloudService.shared.confirmSignUp(with: oneTimePass) {  [weak self] in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: false)
            }
        }
        
        return false
    }

}
