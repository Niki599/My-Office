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
    
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var mainLogo: UIImageView!
    private var loginButton: UIButton!
    private var backgroundView: UIView!
    private var checkBox: UIButton!
    private var rememberMe: UILabel!
    private var check: Bool = true
    let logoImage = UIImage(imageLiteralResourceName: "sebbia-logo.jpg").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    let checkBoxImage = UIImage(imageLiteralResourceName: "checkBox.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
        if (UserDefaults.standard.bool(forKey: "dataAvailability")) {
            loginTextField.text = UserDefaults.standard.string(forKey: "login")
            passwordTextField.text = UserDefaults.standard.string(forKey: "password")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainScreenTabBar")
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    func setupView() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        mainLogo = UIImageView(image: logoImage)
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        mainLogo.layer.cornerRadius = 5
        mainLogo.clipsToBounds = true
        view.addSubview(mainLogo)
        
        loginTextField = UITextField()
        loginTextField.draw(CGRect.init())
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Логин"
        loginTextField.textAlignment = .center
        view.addSubview(loginTextField)
        
        passwordTextField = UITextField()
        passwordTextField.draw(CGRect.init())
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.textAlignment = .center
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Вход", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.init(red: 0.0/255.0, green: 50.0/255.0, blue: 233.0/255.0, alpha: 1)
        loginButton.layer.borderColor = UIColor.init(red: 6.0/255.0, green: 150.0/255.0, blue: 254.0/255.0, alpha: 1).cgColor
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action:#selector(loginAction), for: .touchUpInside)
        loginButton.clipsToBounds = true
        view.addSubview(loginButton)
        
        rememberMe = UILabel()
        rememberMe.translatesAutoresizingMaskIntoConstraints = false
        rememberMe.layer.borderColor = UIColor.black.cgColor
        rememberMe.text = "Запомнить"
        rememberMe.font = UIFont.italicSystemFont(ofSize: 8)
        rememberMe.clipsToBounds = true
        view.addSubview(rememberMe)
        
        checkBox = UIButton()
        checkBox.layer.borderWidth = 1
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        checkBox.layer.cornerRadius = 5
        checkBox.backgroundColor = UIColor.white
        checkBox.layer.borderColor = UIColor.init(red: 6.0/255.0, green: 150.0/255.0, blue: 254.0/255.0, alpha: 1).cgColor
        checkBox.clipsToBounds = true
        checkBox.addTarget(self, action:#selector(automaticLogin), for: .touchUpInside)
        view.addSubview(checkBox)
    }
    
    override func viewDidLayoutSubviews() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainLogo.topAnchor.constraint(equalTo: self.view.topAnchor,constant: screenHeight/4 ),
            mainLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            //            mainLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainLogo.widthAnchor.constraint(equalToConstant: 120),
            mainLogo.heightAnchor.constraint(equalToConstant: 120),
            
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 14),
            loginTextField.leadingAnchor.constraint(equalTo: mainLogo.leadingAnchor, constant: -60),
            loginTextField.trailingAnchor.constraint(equalTo: mainLogo.trailingAnchor, constant: 60),
            loginTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 14),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor)
            
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 14),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 190),
//            loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor,constant: 7),
            loginButton.bottomAnchor.constraint(equalTo: rememberMe.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            checkBox.topAnchor.constraint(equalTo: loginButton.topAnchor),
            checkBox.leadingAnchor.constraint(equalTo: loginButton.trailingAnchor, constant: 10),
//            checkBox.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor ),
//            checkBox.bottomAnchor.constraint(equalTo: loginButton.bottomAnchor),
            checkBox.heightAnchor.constraint(equalTo: loginButton.heightAnchor,constant: -7),
            checkBox.widthAnchor.constraint(equalTo: checkBox.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
                   rememberMe.topAnchor.constraint(equalTo: checkBox.bottomAnchor),
            rememberMe.centerXAnchor.constraint(equalTo: checkBox.centerXAnchor),
                   rememberMe.heightAnchor.constraint(equalToConstant: 10)
               ])
        
        
        
    }
    
    func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .portrait
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.viewDidLayoutSubviews()
    }
    
    @objc func automaticLogin() {

        if (checkBox.isSelected == false && check == true) {
            check = false
            UserDefaults.standard.set(true, forKey: "dataAvailability")
            UserDefaults.standard.set(loginTextField.text, forKey: "login")
            UserDefaults.standard.set(passwordTextField.text, forKey: "password")
            checkBox.setImage(checkBoxImage, for: .normal)
            return
        }
        if (checkBox.isSelected == false && check == false) {
            check = true
            UserDefaults.standard.set(false, forKey: "dataAvailability")
            checkBox.setImage(.none, for: .normal)
    }
    }
    
    @objc func loginAction() {
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

        }
        else {
            loginTextField.layer.borderColor = UIColor.red.cgColor
            passwordTextField.layer.borderColor = UIColor.red.cgColor
        }
    }
}

extension SignIn : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.backgroundColor = .none
        loginTextField.backgroundColor = .none
    }
    
}
