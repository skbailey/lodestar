//
//  ConfirmationViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class ConfirmationViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSegue(withIdentifier: "setupProfile", sender: self)
        return false
    }

}
