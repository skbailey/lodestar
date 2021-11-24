//
//  SettingItemDateOfBirthViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/24/21.
//

import UIKit

class SettingItemDateOfBirthViewController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var navItem: UINavigationItem!
    
    var delegate: ProfileSettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        datePicker.maximumDate = Date()
        navItem.title = title
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        delegate?.didChooseValue(date: datePicker.date)
        
        self.navigationController?.popViewController(animated: false)
    }
}
