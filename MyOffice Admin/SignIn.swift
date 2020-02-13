//
//  ViewController.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase

class SignIn: UIViewController {
    
    // MARK: - Private Properties
    
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var mainLogo: UIImageView!
    private var authorizationButton: UIButton!
    private var backgroundView: UIView!
    private var enteryLabel: UILabel!
    private var createCompanyButton: UIButton!
    /**
     Модель всех сотрудников
     */
    var data = Company.shared
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    
    private let logoImage = UIImage(imageLiteralResourceName: "sebbia-logo.jpg").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    private let checkBoxImage = UIImage(imageLiteralResourceName: "checkBox.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        //Тап по экрану, чтобы спрятать клаву
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        //Реализация автовхода
        if (UserDefaults.standard.bool(forKey: "autoSignIn")) {
            self.authorizationButton.isUserInteractionEnabled = false
            self.loginTextField.isUserInteractionEnabled = false
            self.passwordTextField.isUserInteractionEnabled = false
            self.authorizationButton.isUserInteractionEnabled = false
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    // TODO: Добавить автоопределение компании
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, categories) in uids as! NSDictionary {
                                for (category, fields) in categories as! NSDictionary {
                                    for (nameOfField, valueOfField) in fields as! NSDictionary {
                                        if nameOfField as? String == "admin" {
                                            if hams == uid as? String {
                                                UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                UserDefaults.standard.set(company, forKey: "company")
                                            }
                                            self.oneOfUsers.work.admin = valueOfField as? Bool
                                            continue
                                        }
                                        if nameOfField as? String == "check" {
                                            self.oneOfUsers.work.check = valueOfField as? Bool
                                            continue
                                        }
                                        if nameOfField as? String == "coming" {
                                            self.oneOfUsers.work.coming = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "leaving" {
                                            self.oneOfUsers.work.leaving = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "monthHours" {
                                            self.oneOfUsers.work.monthHours = valueOfField as? Int
                                            continue
                                        }
                                        if nameOfField as? String == "totalHours" {
                                            self.oneOfUsers.work.totalHours = valueOfField as? Int
                                            continue
                                        }
                                        if nameOfField as? String == "weekHours" {
                                            self.oneOfUsers.work.weekHours = valueOfField as? Int
                                            continue
                                        }
                                        if nameOfField as? String == "date" {
                                            self.oneOfUsers.info.date = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "email" {
                                            self.oneOfUsers.info.email = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "name" {
                                            self.oneOfUsers.info.name = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "pass" {
                                            self.oneOfUsers.info.pass = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "phone" {
                                            self.oneOfUsers.info.phone = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "surname" {
                                            self.oneOfUsers.info.surname = valueOfField as? String
                                            continue
                                        }
                                    }
                                }
                                self.data.users.append(self.oneOfUsers)
                            }
                        }
                        self.authorizationButton.isUserInteractionEnabled = true
                        self.loginTextField.isUserInteractionEnabled = true
                        self.passwordTextField.isUserInteractionEnabled = true
                        self.authorizationButton.isUserInteractionEnabled = true
                        let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                        MainScreenTabBarVC.data = self.data
                        self.navigationController?.pushViewController(MainScreenTabBarVC, animated: true)
                    })
                }
                else {
                    // Очистка всего UserDefaults, если вход не был выполнен
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        self.authorizationButton.isUserInteractionEnabled = true
                        self.loginTextField.isUserInteractionEnabled = true
                        self.passwordTextField.isUserInteractionEnabled = true
                        self.authorizationButton.isUserInteractionEnabled = true
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.loginTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    override func viewDidLayoutSubviews() {
        
        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
        let space = screenWidth/2
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainLogo.topAnchor.constraint(equalTo: view.topAnchor,constant: space / 1.8 ),
            mainLogo.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor,constant: space / 4 ),
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
            createCompanyButton.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -50),
            createCompanyButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            createCompanyButton.widthAnchor.constraint(equalTo: enteryLabel.widthAnchor),
            createCompanyButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor, constant: -20),
            authorizationButton.bottomAnchor.constraint(equalTo: createCompanyButton.topAnchor, constant: -10),
            authorizationButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            authorizationButton.widthAnchor.constraint(equalTo: enteryLabel.widthAnchor),
            authorizationButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
        ])
        
        NSLayoutConstraint.activate([
            enteryLabel.leadingAnchor.constraint(equalTo: mainLogo.leadingAnchor),
            enteryLabel.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 44),
            enteryLabel.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -space/4)
        ])
    }
    
    deinit {
        loginTextField = nil
        passwordTextField = nil
        mainLogo = nil
        authorizationButton = nil
        backgroundView = nil
        enteryLabel = nil
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        mainLogo = UIImageView(image: logoImage)
        mainLogo.translatesAutoresizingMaskIntoConstraints = false
        mainLogo.layer.cornerRadius = 5
        mainLogo.clipsToBounds = true
        view.addSubview(mainLogo)
        
        enteryLabel = UILabel()
        enteryLabel.translatesAutoresizingMaskIntoConstraints = false
        enteryLabel.layer.borderColor = UIColor.black.cgColor
        enteryLabel.text = "Добро пожаловать"
        enteryLabel.numberOfLines = 3
        enteryLabel.textAlignment = .center
        enteryLabel.font = UIFont.italicSystemFont(ofSize: 32)
        enteryLabel.clipsToBounds = true
        view.addSubview(enteryLabel)
        
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
        passwordTextField.layer.addSublayer(bottomLine)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .left
        passwordTextField.clipsToBounds = true
        view.addSubview(passwordTextField)
        
        authorizationButton = UIButton()
        authorizationButton.layer.borderWidth = 1
        authorizationButton.layer.cornerRadius = 5
        authorizationButton.setTitle("Присоединиться", for: .normal)
        authorizationButton.setTitleColor(.white, for: .normal)
        authorizationButton.setTitleColor(.lightGray, for: .highlighted)
        authorizationButton.backgroundColor = .black
        authorizationButton.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.addTarget(self, action:#selector(didAuthButtonTap), for: .touchUpInside)
        authorizationButton.clipsToBounds = true
        view.addSubview(authorizationButton)
        
        createCompanyButton = UIButton()
        createCompanyButton.setTitle("Регистрация компании", for: .normal)
        createCompanyButton.setTitleColor(.black, for: .normal)
        createCompanyButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 0.4) , for: .highlighted)
        createCompanyButton.backgroundColor = .none
        createCompanyButton.translatesAutoresizingMaskIntoConstraints = false
        createCompanyButton.clipsToBounds = true
        createCompanyButton.addTarget(self, action:#selector(didCreateCompanyButtonTap), for: .touchUpInside)
        view.addSubview(createCompanyButton)
        
    }
            
    @objc private func didAuthButtonTap() {
        self.authorizationButton.isUserInteractionEnabled = false
        self.loginTextField.isUserInteractionEnabled = false
        self.passwordTextField.isUserInteractionEnabled = false
        self.authorizationButton.isUserInteractionEnabled = false
        if !(loginTextField.text! == "" || passwordTextField.text! == "") {
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    // TODO: Добавить автоопределение компании
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, categories) in uids as! NSDictionary {
                                for (category, fields) in categories as! NSDictionary {
                                    for (nameOfField, valueOfField) in fields as! NSDictionary {
                                        if nameOfField as? String == "admin" {
                                            if hams == uid as? String {
                                                UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                UserDefaults.standard.set(company, forKey: "company")
                                            }
                                            self.oneOfUsers.work.admin = valueOfField as? Bool
                                            continue
                                        }
                                        if nameOfField as? String == "check" {
                                            self.oneOfUsers.work.check = valueOfField as? Bool
                                            continue
                                        }
                                        if nameOfField as? String == "coming" {
                                            self.oneOfUsers.work.coming = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "leaving" {
                                            self.oneOfUsers.work.leaving = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "monthHours" {
                                            self.oneOfUsers.work.monthHours = valueOfField as? Int
                                            continue
                                        }
                                        if nameOfField as? String == "totalHours" {
                                            self.oneOfUsers.work.totalHours = valueOfField as? Int
                                            continue
                                        }
                                        if nameOfField as? String == "weekHours" {
                                            self.oneOfUsers.work.weekHours = valueOfField as? Int
                                            continue
                                        }
                                        if nameOfField as? String == "date" {
                                            self.oneOfUsers.info.date = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "email" {
                                            self.oneOfUsers.info.email = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "name" {
                                            self.oneOfUsers.info.name = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "pass" {
                                            self.oneOfUsers.info.pass = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "phone" {
                                            self.oneOfUsers.info.phone = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "surname" {
                                            self.oneOfUsers.info.surname = valueOfField as? String
                                            continue
                                        }
                                    }
                                }
                                self.data.users.append(self.oneOfUsers)
                            }
                        }
                        
                        UserDefaults.standard.set(true, forKey: "autoSignIn")
                        UserDefaults.standard.set(self.loginTextField.text, forKey: "login")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                        self.authorizationButton.isUserInteractionEnabled = true
                        self.loginTextField.isUserInteractionEnabled = true
                        self.passwordTextField.isUserInteractionEnabled = true
                        self.authorizationButton.isUserInteractionEnabled = true
                        let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                        MainScreenTabBarVC.data = self.data
                        self.navigationController?.pushViewController(MainScreenTabBarVC, animated: true)
                    })
                }
                else {
                    // Очистка всего UserDefaults, если вход не был выполнен
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                        self.authorizationButton.isUserInteractionEnabled = true
                        self.loginTextField.isUserInteractionEnabled = true
                        self.passwordTextField.isUserInteractionEnabled = true
                        self.authorizationButton.isUserInteractionEnabled = true
                    }
                }
            })
            
        }
        else {
            if (loginTextField.text == "") {
                loginTextField.layer.backgroundColor = .init(srgbRed: 0, green: 255, blue: 0, alpha: 0.6)
            }
            if (passwordTextField.text == "") {
                passwordTextField.layer.backgroundColor = .init(srgbRed: 0, green: 255, blue: 0, alpha: 0.6)
            }
            // Очистка всего UserDefaults, если вход не был выполнен
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
                self.authorizationButton.isUserInteractionEnabled = true
                self.loginTextField.isUserInteractionEnabled = true
                self.passwordTextField.isUserInteractionEnabled = true
                self.authorizationButton.isUserInteractionEnabled = true
            }
        }
    }
    
    @objc func didCreateCompanyButtonTap() {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
//        signUpVC.typeOfSignUp = false
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
}

extension SignIn : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.backgroundColor = .none
        loginTextField.backgroundColor = .none
    }
    
}

