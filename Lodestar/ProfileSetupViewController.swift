//
//  ProfileSetupViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/17/21.
//

import UIKit

struct Setting {
    var code: String
    var name: String
    var values: [String]
    var selected: String = "Fill In"
}

protocol ProfileSettingsDelegate {
    func didChooseValue(index: Int) -> Void
    func didChooseValue(date: Date) -> Void
}

class ProfileSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
                                  ProfileSettingsDelegate {
    
    @IBOutlet weak var settingsTable: UITableView!
    var profileSettings: [Setting]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileSettings = [
            Setting(code: "date-of-birth", name: "Date of Birth", values: []),
            Setting(code: "height", name: "Height", values: Height.formattedRange),
            Setting(code: "weight", name: "Weight", values: Weight.formattedRange),
            Setting(code: "ethnicity", name: "Ethnicity", values: Ethnicity.rangeOfValues()),
            Setting(code: "gender", name: "Gender", values: Gender.rangeOfValues()),
        ]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = settingsTable.indexPathForSelectedRow
        let setting = profileSettings[indexPath!.row]

        if segue.identifier == "updateSettingItem" {
            let destination = segue.destination as! SettingsItemViewController
            destination.title = setting.name
            destination.pickerValues = setting.values
            destination.delegate = self
        } else if segue.identifier == "updateSettingItemDateOfBirth" {
            let destination = segue.destination as! SettingItemDateOfBirthViewController
            destination.title = setting.name
            destination.delegate = self
        }
    }
    
    // MARK: UITableView DataSource and Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSettingCell", for: indexPath)
        
        let setting = profileSettings[indexPath.row]
        
        cell.textLabel?.text = setting.name
        cell.detailTextLabel?.text = String(describing: setting.selected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            performSegue(withIdentifier: "updateSettingItem", sender: self)
        } else {
            performSegue(withIdentifier: "updateSettingItemDateOfBirth", sender: self)
        }
    }

    // MARK: ProfileSettingsDelegate methods
    
    func didChooseValue(index selectedIndex: Int) {
        let indexPath = settingsTable.indexPathForSelectedRow
        let setting = profileSettings[indexPath!.row]
        let value = setting.values[selectedIndex]
        let cell = settingsTable.cellForRow(at: indexPath!)
        cell?.detailTextLabel?.text = value
    }
    
    func didChooseValue(date selectedDate: Date) {
        let dateOfBirth = DateOfBirth(current: selectedDate)
        let indexPath = settingsTable.indexPathForSelectedRow
        let cell = settingsTable.cellForRow(at: indexPath!)
        cell?.detailTextLabel?.text = dateOfBirth.formatted
    }
}
