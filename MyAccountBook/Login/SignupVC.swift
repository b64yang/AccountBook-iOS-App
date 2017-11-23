//
//  SignupVC.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-25.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit
import CoreData

protocol infoPopulatedDelegate {
    func infoFilled(userName: String, password: String, name: String, age: Int)
}

class SignupVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var submitBtnConstraint: NSLayoutConstraint!
    
    var signupDelegate: infoPopulatedDelegate? = nil
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidLoad() {
        usernameTF.delegate = self
        passwordTF.delegate = self
        nameTF.delegate = self
        ageTF.delegate = self
        ageTF.keyboardType = .decimalPad
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let height = keyboardSize.height
            self.submitBtnConstraint.constant = height + 30
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        self.submitBtnConstraint.constant = 50
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        if signupDelegate != nil {
            if usernameTF.text != "", passwordTF.text != "", nameTF.text != "", ageTF.text != ""  {
                if let age = Int(ageTF.text!) {
                    let username = usernameTF.text!
                    let password = passwordTF.text!
                    let name = nameTF.text!
                    // need to fill in completion with core data function
                    let flag = try? User.userExists( for: username, in: PersistenceService.context)
                    if flag! {
                        let alert = AlertCenter.createAlert(title: "username existed", message: "create account with another username")
                        present(alert, animated: true, completion: nil)
                        return
                    }else{
                        // (context) in the trailing closure is the managedObjectContext of the other queue(the private queue
                        // that the task is being performed on, and it should be connected through persistant store. when we save either of the two contexts( the main one and the private one) the changes would be migrated to another one.
                        // which is why we add the user on private queue with function User.creates() but can query it from the main queue with function User.userExists()
                        PersistenceService.persistentContainer.performBackgroundTask { (context) in
                            let _ = User.creates(context: context, username: username, password: password,name:  name, age: Int32(age))
                            try? context.save()
                        }
                    }
                    signupDelegate?.infoFilled( userName: username, password: password, name: name, age: age)
                    navigationController?.popViewController(animated: true)
                    //dismiss(animated: true, completion: nil)
                }
                else{
                    let alert = AlertCenter.createAlert(title: "Wrong age", message: "Just Put In Your Actual Age!!!")
                    present(alert, animated: true, completion: nil)
                }
            }
            else {
                let alert = AlertCenter.createAlert(title: "Missing Data", message: "One or more field unfilled")
                present(alert, animated: true, completion: nil)
                //createAlert(title: "Missing Data", message: "One or more field unfilled")
            }
        }else {
            let alert = AlertCenter.createAlert(title: "No Delegate", message: "Check your Delegate")
            present(alert, animated: true, completion: nil)
        }
    }

}
