//
//  SettingsViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/20/21.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        // TODO: This is async, use a callback to update UI
        CloudService.shared.signOut()
        
        self.navigationController?.popToRootViewController(animated: false)
    }
}
