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
    private var enteryLabel: UILabel!
    private var check: Bool = true
    private let logoImage = UIImage(imageLiteralResourceName: "sebbia-logo.jpg").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    private let checkBoxImage = UIImage(imageLiteralResourceName: "checkBox.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    
    
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
            self.navigationController?.pushViewController(vc, animated: false)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    deinit {
        loginTextField = nil
        passwordTextField = nil
        mainLogo = nil
        loginButton = nil
        backgroundView = nil
        enteryLabel = nil
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
        loginTextField.autocapitalizationType = .none
        loginTextField.textAlignment = .left
        view.addSubview(loginTextField)
        
        
        passwordTextField = UITextField()
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x:0.0, y:100.0, width: passwordTextField.frame.width, height: passwordTextField.frame.height - 1)
        bottomLine.backgroundColor = UIColor.black.cgColor
        //        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(bottomLine)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .left
        passwordTextField.clipsToBounds = true
        view.addSubview(passwordTextField)
        
        loginButton = UIButton()
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 5
        loginButton.setTitle("Присоединиться", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.init(red: 0.0/255.0, green: 50.0/255.0, blue: 233.0/255.0, alpha: 1)
        loginButton.layer.borderColor = UIColor.init(red: 6.0/255.0, green: 150.0/255.0, blue: 254.0/255.0, alpha: 1).cgColor
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action:#selector(loginAction), for: .touchUpInside)
        loginButton.clipsToBounds = true
        view.addSubview(loginButton)
        
        enteryLabel = UILabel()
        enteryLabel.translatesAutoresizingMaskIntoConstraints = false
        enteryLabel.layer.borderColor = UIColor.black.cgColor
        enteryLabel.text = "Добро пожаловать в SEBBIA"
        enteryLabel.numberOfLines = 3
        enteryLabel.font = UIFont.italicSystemFont(ofSize: 32)
        enteryLabel.clipsToBounds = true
        view.addSubview(enteryLabel)
        
    }
    
    override func viewDidLayoutSubviews() {
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let space = screenWidth/2
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainLogo.topAnchor.constraint(equalTo: self.view.topAnchor,constant: space / 1.8 ),
            //            mainLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mainLogo.leadingAnchor.constraint(equalTo: self.view.safeArea.leadingAnchor,constant: space / 4 ),
            //            mainLogo.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            mainLogo.widthAnchor.constraint(equalToConstant: space / 4),
            mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor),
            
        ])
        
        NSLayoutConstraint.activate([
            loginTextField.topAnchor.constraint(equalTo: enteryLabel.bottomAnchor, constant: space / 3),
            loginTextField.leadingAnchor.constraint(equalTo: enteryLabel.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: enteryLabel.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 14),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor)
            
        ])
        
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: self.view.safeArea.bottomAnchor, constant: -44),
            //            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.centerXAnchor.constraint(equalTo: self.view.safeArea.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: enteryLabel.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
            //            loginButton.bottomAnchor.constraint(equalTo: rememberMe.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            enteryLabel.leadingAnchor.constraint(equalTo: mainLogo.leadingAnchor),
            enteryLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 44),
            enteryLabel.trailingAnchor.constraint(equalTo: self.view.safeArea.trailingAnchor, constant: -space/4)
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.viewDidLayoutSubviews()
    }
    
    @objc func loginAction() {
        self.loginButton.isUserInteractionEnabled = false
        self.loginTextField.isUserInteractionEnabled = false
        self.passwordTextField.isUserInteractionEnabled = false
        if !(loginTextField.text! == "" || passwordTextField.text! == "") {
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if ((user) != nil) {
                    
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference().child("users")
                    
                    let t = Thread {
                        base.observe(.value, with:  { (snapshot) in
                            guard let value = snapshot.value, snapshot.exists() else { return }
                            let dict: NSDictionary = value as! NSDictionary
                            for (uid, uidEmployeerInfo) in dict {
                                if ((uid as! String) == hams) {
                                    for (_, categ) in uidEmployeerInfo as! NSDictionary {
                                        for (fieldName, valueOfField) in categ as! NSDictionary {
                                            if fieldName as? String == "admin" {
                                                UserDefaults.standard.set(valueOfField as! Bool, forKey: "admin")
                                            }
                                        }
                                    }
                                }
                            }
                        })
                    }

                    t.stackSize = 1024 * 16
                    t.start()
        
                    UserDefaults.standard.set(true, forKey: "dataAvailability")
                    UserDefaults.standard.set(self.loginTextField.text, forKey: "login")
                    UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                    self.loginButton.isUserInteractionEnabled = true
                    self.loginTextField.isUserInteractionEnabled = true
                    self.passwordTextField.isUserInteractionEnabled = true
                    self.loginTextField.text = ""
                    self.passwordTextField.text = ""
                    
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "MainScreenTabBar")
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                else {
                    // Очистка всего UserDefaults
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        self.loginButton.isUserInteractionEnabled = true
                        self.loginTextField.isUserInteractionEnabled = true
                        self.passwordTextField.isUserInteractionEnabled = true
                    }
                }
            })
            
        }
        else {
            if (loginTextField.text == "") {
                loginTextField.layer.backgroundColor = .init(srgbRed: 0, green: 255, blue: 0, alpha: 1)
            }
            if (passwordTextField.text == "") {
                passwordTextField.layer.backgroundColor = .init(srgbRed: 0, green: 255, blue: 0, alpha: 1)
            }
            self.loginButton.isUserInteractionEnabled = true
            self.loginTextField.isUserInteractionEnabled = true
            self.passwordTextField.isUserInteractionEnabled = true
        }
    }
}

extension SignIn : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.backgroundColor = .none
        loginTextField.backgroundColor = .none
    }
    
}

