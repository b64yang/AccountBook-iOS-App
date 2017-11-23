//
//  LoginVC.swift
//  MyAccountBook
//
//  Created by Bowen Yang on 2017-10-25.
//  Copyright © 2017 Bowen Yang. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, infoPopulatedDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var UsernameTF: UITextField!
    @IBOutlet weak var PasswordTF: UITextField!
    
    @IBAction func loginBtn(_ sender: Any) {
        if UsernameTF.text != "", PasswordTF.text != "" {
            let flag = try? User.userCanLogin( with: UsernameTF.text!, and: PasswordTF.text!, in: PersistenceService.context)
            if flag! {
                let username = UsernameTF.text!
                PersistenceService.persistentContainer.performBackgroundTask { (context) in
                    let currentUser = try? User.fetchUser(with: username, in: PersistenceService.context)
                    CurrentUserInfo.username = currentUser!.username!
                    CurrentUserInfo.password = currentUser!.password!
                    CurrentUserInfo.name = currentUser!.name!
                    CurrentUserInfo.age = Int(currentUser!.age)
                }
                performSegue(withIdentifier: "showLandingContainer", sender: nil)
            }else {
                let alert = AlertCenter.createAlert(title: "Did not find user info", message: "wrong username or password or BOTH!!")
                present(alert, animated: true, completion: { [weak self] in self?.PasswordTF.text! = ""; self?.UsernameTF.text! = ""})
            }
        }else {
            let alert = AlertCenter.createAlert(title: "Username or Password required!", message: "Don't play with me! Put in ur username and password!")
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PasswordTF.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSignUp" {
            let signupVC = segue.destination as! SignupVC
            signupVC.signupDelegate = self
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func infoFilled(userName: String, password: String, name: String, age: Int) {
        UsernameTF.text = userName
        PasswordTF.text = password
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return false to ignore.
    {
        textField.resignFirstResponder()
        return true
    }

}
