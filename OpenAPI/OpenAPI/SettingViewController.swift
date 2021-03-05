//
//  SettingViewController.swift
//  OpenAPI
//
//  Created by meng on 2021/03/05.
//

import UIKit

class SettingViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            NotificationCenter.default.post(name: Notification.Name("logoutButtonClicked"), object: nil)
            self.dismiss(animated: true, completion: nil)
            print("a")
        }
        
    }
}
