//
//  SignupViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/16/21.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        performSegue(withIdentifier: "confirm", sender: self)
    }
    
}
