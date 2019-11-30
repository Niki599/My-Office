//
//  ViewController.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignIn: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func loginButton(_ sender: Any) {
        if (loginTextField.text != nil && passwordTextField.text != nil) {
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if (error == nil) {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference().child("users").child(hams!)
                    base.updateChildValues(["check":false])
    //                self.indicator?.image = UIImage(named: "Yellow.png")
//                    if let appDomain = Bundle.main.bundleIdentifier {
//                    UserDefaults.standard.removePersistentDomain(forName: appDomain)
//                    }
//                    TODO: Выход из всех userDefaults
                }
                else {
                    
                }
            })
            UserDefaults.standard.set(true, forKey: "dataAvailability")
            UserDefaults.standard.set(loginTextField.text, forKey: "login")
            UserDefaults.standard.set(passwordTextField.text, forKey: "password")
        }
        else {
            loginTextField.backgroundColor = UIColor(red: 150, green: 75, blue: 75, alpha: 0.3)
            passwordTextField.backgroundColor = UIColor(red: 150, green: 75, blue: 75, alpha: 0.3)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        //TODO: Проверять наличие "Уже входил" и автоматически входить
        if (UserDefaults.standard.bool(forKey: "dataAvailability")) {
            loginTextField.text = UserDefaults.standard.string(forKey: "login")
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")
        }
        else {
            
        }
    }
}

extension SignIn : UITextFieldDelegate {
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            passwordTextField.backgroundColor = .none
            loginTextField.backgroundColor = .none
        }
    
}
