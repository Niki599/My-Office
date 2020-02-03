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
    
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var mainLogo: UIImageView!
    private var loginButton: UIButton!
    private var backgroundView: UIView!
    private var enteryLabel: UILabel!
    /**
     Модель всех сотрудников
     */
    var data = Company.shared
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    
    var quantityEmployeers: Int!
    
    private let logoImage = UIImage(imageLiteralResourceName: "sebbia-logo.jpg").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    private let checkBoxImage = UIImage(imageLiteralResourceName: "checkBox.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        //Тап по экрану, чтобы спрятать клаву
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        //Реализация автовхода
        if (UserDefaults.standard.bool(forKey: "dataAvailability")) {
            // TODO: Добавить передачу данных
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MainScreenTabBar")
            self.navigationController?.pushViewController(vc, animated: false)
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
        enteryLabel.text = "Добро пожаловать"
        enteryLabel.numberOfLines = 3
        enteryLabel.textAlignment = .center
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
            mainLogo.leadingAnchor.constraint(equalTo: self.view.safeArea.leadingAnchor,constant: space / 4 ),
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
            loginButton.centerXAnchor.constraint(equalTo: self.view.safeArea.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: enteryLabel.widthAnchor),
            loginButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
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
                    // TODO: Добавить автоопределение компании
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    self.quantityEmployeers = 0
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, categories) in uids as! NSDictionary {
                                for (_, _) in uids as! NSDictionary {
                                    self.quantityEmployeers += 1
                                }
                                if hams == uid as! String {
//                                    UserDefaults.standard.set(<#T##value: Bool##Bool#>, forKey: "admin")
                                }
                                for (category, fields) in categories as! NSDictionary {
                                    for (nameOfField, valueOfField) in fields as! NSDictionary {
                                        if nameOfField as? String == "admin" {
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
                        
                        UserDefaults.standard.set(true, forKey: "dataAvailability")
                        UserDefaults.standard.set(self.loginTextField.text, forKey: "login")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                        self.loginButton.isUserInteractionEnabled = true
                        self.loginTextField.isUserInteractionEnabled = true
                        self.passwordTextField.isUserInteractionEnabled = true
                        // TODO: Разобраться с потоками
                        DispatchQueue.main.async {
                            //                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            //                        let vc = storyboard.instantiateViewController(withIdentifier: "MainScreenTabBar")
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                            vc.data = self.data
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    })
                    
                }
                else {
                    // Очистка всего UserDefaults, если вход не был выполнен
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
                loginTextField.layer.backgroundColor = .init(srgbRed: 0, green: 255, blue: 0, alpha: 0.6)
            }
            if (passwordTextField.text == "") {
                passwordTextField.layer.backgroundColor = .init(srgbRed: 0, green: 255, blue: 0, alpha: 0.6)
            }
            // Очистка всего UserDefaults, если вход не был выполнен
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
                self.loginButton.isUserInteractionEnabled = true
                self.loginTextField.isUserInteractionEnabled = true
                self.passwordTextField.isUserInteractionEnabled = true
            }
        }
    }
}

extension SignIn : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        passwordTextField.backgroundColor = .none
        loginTextField.backgroundColor = .none
    }
    
}

