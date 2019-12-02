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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        if (UserDefaults.standard.bool(forKey: "dataAvailability")) {
            loginTextField.text = UserDefaults.standard.string(forKey: "login")
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainMenu")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if (loginTextField.text != nil && passwordTextField.text != nil) {
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if (error == nil) {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference().child("users").child(hams!)
                    base.updateChildValues(["check":false])
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainMenu")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                else {
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
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
}

extension SignIn : UITextFieldDelegate {
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            passwordTextField.backgroundColor = .none
            loginTextField.backgroundColor = .none
        }
    
}
