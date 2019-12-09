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
    
    @IBOutlet var loginTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var mainLogo: UIImageView!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        updateConstraints()
    }
    
    func setupView() {
        
        
        mainLogo = UIImageView()
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainLogo)
        loginTextField = UITextField()
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginTextField)

        passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)

        loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)

        
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        if (UserDefaults.standard.bool(forKey: "dataAvailability")) {
            loginTextField.text = UserDefaults.standard.string(forKey: "login")
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainScreenTabBar")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        updateConstraints()
    }
    
    func updateConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        NSLayoutConstraint.activate([
            mainLogo.topAnchor.constraint(equalTo: self.view.topAnchor,constant: (screenHeight / 2) - 50 ),
            mainLogo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: screenWidth / 2 - 45),
            mainLogo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: screenWidth / 2 + 45),
            mainLogo.widthAnchor.constraint(equalToConstant: 190),
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 14),
            loginTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth / 2 - 83),
            loginTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: screenWidth / 2 + 83)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 14),
            passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth / 2 - 83),
            passwordTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: screenWidth / 2 + 83)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 14),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: screenWidth / 2 - 83),
//            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: screenWidth / 2 + 83)
        ])
    }
    
    @IBAction func loginButton(_ sender: Any) {
        if (loginTextField.text != nil && passwordTextField.text != nil) {
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if (error == nil) {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference().child("users").child(hams!)
                    base.updateChildValues(["check":false])
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "MainScreenTabBar")
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
