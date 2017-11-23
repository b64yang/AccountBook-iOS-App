//
//  ProfileVC.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-31.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    var passwordVisible = true
    
    @IBAction func togglePassword(_ sender: Any) {
        if(passwordVisible == true) {
            passwordLabel.isHidden = false
            passwordVisible = false
        } else {
            passwordLabel.isHidden = true
            passwordVisible = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = CurrentUserInfo.name
        ageLabel.text = String(CurrentUserInfo.age)
        usernameLabel.text = CurrentUserInfo.username
        passwordLabel.isHidden = true
        passwordLabel.text = CurrentUserInfo.password
    }
}
