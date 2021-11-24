//
//  SettingsItemViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/22/21.
//

import UIKit

protocol ProfileSettingsDelegate {
    func didChooseValue(index: Int) -> Void
}

class SettingsItemViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var navItem: UINavigationItem!
    var pickerValues: [String]!
    
    var delegate: ProfileSettingsDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navItem.title = title
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func done(_ sender: Any) {
        let row = picker.selectedRow(inComponent: 0)
        delegate.didChooseValue(index: row)
        
        self.navigationController?.popViewController(animated: false)
    }
    
    // MARK: UIPickerViewDataSource methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues.count
    }
    
    // MARK: UIPickerViewDelegate methods
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = pickerValues[row]
        return value
    }
}
