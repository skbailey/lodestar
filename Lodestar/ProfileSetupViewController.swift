//
//  ProfileSetupViewController.swift
//  Lodestar
//
//  Created by Bailey on 11/17/21.
//

import UIKit

struct Setting {
    var name: String
    var value: Any?
}

class ProfileSetupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var profileSettings: [Setting] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileSettings = [Setting(name: "Age", value: "Fill in")]
    }
    
    // Mark: UITableView DataSource and Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileSettingCell", for: indexPath)
        
        let setting = profileSettings[indexPath.row]
        
        cell.textLabel?.text = setting.name
        cell.detailTextLabel?.text = String(describing: setting.value)
        
        return cell
    }

}
