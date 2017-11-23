//
//  SideMenuTVC.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-22.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class SideMenuTVC: UITableViewController {

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(redirectToLoginPage), name: NSNotification.Name("logout"), object: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        
        switch indexPath.row {
            case 0: NotificationCenter.default.post(name: NSNotification.Name("ShowProfile"), object: nil)
            case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowShoppingList"), object: nil)
            case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowCharts"), object: nil)
            case 3: NotificationCenter.default.post(name: NSNotification.Name("ShowViewHistory"), object: nil)
            case 4: self.logout()
            default: break
        }
        
    }
    
    func logout() {
//        CurrentUserInfo.username = ""
//        CurrentUserInfo.password = ""
//        CurrentUserInfo.name = ""
//        CurrentUserInfo.age = 0
        let alert = AlertCenter.createLogoutAlert(title: "Logout", message: "do u really want to log out?")
        present(alert, animated: true, completion: nil)
    }
    
    @objc func redirectToLoginPage() {
        performSegue(withIdentifier: "showLogin", sender: nil)
    }
    

}
