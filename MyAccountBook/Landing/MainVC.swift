//
//  MainVC.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-23.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBAction func onMenuTapped() {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showProfile),
                                               name: NSNotification.Name("ShowProfile"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showShoppingList),
                                               name: NSNotification.Name("ShowShoppingList"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showCharts),
                                               name: NSNotification.Name("ShowCharts"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showViewHistory),
                                               name: NSNotification.Name("ShowViewHistory"),
                                               object: nil)
    }
    
    @objc func showProfile() {
        performSegue(withIdentifier: "ShowProfile", sender: nil)
    }
    
    @objc func showShoppingList() {
        performSegue(withIdentifier: "ShowShoppingList", sender: nil)
    }
    
    @objc func showCharts() {
        performSegue(withIdentifier: "ShowCharts", sender: nil)
    }
    @objc func showViewHistory() {
        performSegue(withIdentifier: "ShowViewHistory", sender: nil)
    }

}
