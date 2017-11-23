//
//  currentUserInfo.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-29.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import Foundation

class CurrentUserInfo {
    static var username: String = ""
    static var password: String = ""
    static var name: String = ""
    static var age: Int = 0
    static var wantToLogout = false {
        didSet {
            if self.wantToLogout == true {
                self.username = ""
                self.password = ""
                self.name = ""
                self.age = 0
                self.wantToLogout = false
                NotificationCenter.default.post(name: NSNotification.Name("logout"), object: nil)
            }
        }
    }
}
