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
    
    /**
     Модель всех сотрудников
     */
    private var data = Company.shared
    private var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    private var loginTextField: UITextField!
    private var passwordTextField: UITextField!
    private var mainLogo: UIImageView!
    private var authorizationButton: UIButton!
    private var backgroundView: UIView!
    private var enteryLabel: UILabel!
    
    private let logoImage = UIImage(imageLiteralResourceName: "donkomlekt.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    private let checkBoxImage = UIImage(imageLiteralResourceName: "checkBox.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        /**
         Тап по экрану, чтобы спрятать клаву
         */
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        /**
         Реализация автовхода
         */
        if (UserDefaults.standard.bool(forKey: "autoSignIn")) {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.frame = view.bounds
            activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
            
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    self.oneOfUsers.coming.removeAll()
                    self.oneOfUsers.days.removeAll()
                    self.oneOfUsers.leaving.removeAll()
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, _) in uids as! NSDictionary {
                                if hams == uid as? String {
                                    UserDefaults.standard.set(company, forKey: "company")
                                }
                            }
                        }
//                        var a = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company") ?? "").\(hams).coming") as! NSDictionary //В последствии, обнаружил как взять значения без циклов, но не успеваю переписать до диплома
                       /** self.oneOfUsers.work.check = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.check") as? Bool
                        if hams == uid as? String {
                            UserDefaults.standard.set(dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.admin"), forKey: "admin")
                        }
                        self.oneOfUsers.work.admin = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.admin") as? Bool
                        self.oneOfUsers.info.patronymic = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.patronymic") as? String
                        self.oneOfUsers.work.wifi = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.wifi") as? String
                        self.oneOfUsers.work.monthHours = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.monthHours") as? Double
                        self.oneOfUsers.work.weekHours = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.weekHours") as? Double
                        self.oneOfUsers.work.totalHours = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).work.totalHours") as? Double
                        self.oneOfUsers.info.date = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.date") as? String
                        self.oneOfUsers.info.email = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.email") as? String
                        self.oneOfUsers.info.name = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.name") as? String
                        self.oneOfUsers.info.pass = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.pass") as? String
                        self.oneOfUsers.info.phone = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.phone") as? String
                        self.oneOfUsers.info.surname = dict.value(forKeyPath: "\(UserDefaults.standard.string(forKey: "company")!).\(uid).info.surname") as? String
                         **/

                        if Calendar.current.component(.weekday, from: Date()) == 2 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["weekHours": 0])
                        }
                        if Calendar.current.component(.day, from: Date()) == 1 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["monthHours": 0])
                        }
                        for (company, uids) in dict {
                            if company as? String == UserDefaults.standard.string(forKey: "company") {
                                for (uid, categories) in uids as! NSDictionary {
                                    for (category, fields) in categories as! NSDictionary {
                                        if category as? String == "coming" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("coming").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.days.append(nameOfField as! String)
                                                    self.oneOfUsers.coming.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        if category as? String == "leaving" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("leaving").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.leaving.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        for (nameOfField, valueOfField) in fields as! NSDictionary {
                                            if nameOfField as? String == "admin" {
                                                if hams == uid as? String {
                                                    UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                }
                                                self.oneOfUsers.work.admin = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "check" {
                                                self.oneOfUsers.work.check = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "patronymic" {
                                                self.oneOfUsers.info.patronymic = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "wifi" {
                                                self.oneOfUsers.work.wifi = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "monthHours" {
                                                self.oneOfUsers.work.monthHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "totalHours" {
                                                self.oneOfUsers.work.totalHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "weekHours" {
                                                self.oneOfUsers.work.weekHours = valueOfField as? Double
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
                                    self.oneOfUsers.coming.removeAll()
                                    self.oneOfUsers.days.removeAll()
                                    self.oneOfUsers.leaving.removeAll()
                                }
                            }
                        }
                        activityIndicator.stopAnimating() // TODO: - Вовремя
                        let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                        MainScreenTabBarVC.data = self.data
                        MainScreenTabBarVC.modalPresentationStyle = .fullScreen
                        MainScreenTabBarVC.modalTransitionStyle = .flipHorizontal
                        self.present(MainScreenTabBarVC, animated: true, completion: nil)
                    })
                } else {
                    let alert = UIAlertController(title: "Вход не удался", message: "Автовход был очищен", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    // Очистка всего UserDefaults, если вход не был выполнен
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
                    activityIndicator.stopAnimating() // TODO: - Вовремя
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    // TODO: - Если человек находится в приложении, и я меняю значения в Firebase, то как нам известно из другой задачи
    // приложение начнет обновляться (разобраться почему). Обновится весь NavigationStack и вызовет эти две строчки
    // на когда будет проходить через этот VC
    //    UserDefaults.standard.set(self.loginTextField.text?.lowercased(), forKey: "login")
    //    UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
    // После этого он запомнит пустые строчки, так как мы их делаем пустыми после ухода, для того чтобы, когда мы
    // нажимали "Выход" строчки были пустыми, и впредь, когда мы будем пробовать получать доступ к Firebase, он будет
    // вставлять пустые строчки, из-за чего приложение крашится.
    // Вариант решения сделать Alert с TextView, чтобы всегда входить заново при обновлении модели
    
    // Решил это топорным методом постоянного выхода (popVC)
    // Можно почти полностью это решить сделав переход модальным окном без navigation crontroller

//    override func viewDidDisappear(_ animated: Bool) {
//        self.loginTextField.text = ""
//        self.passwordTextField.text = ""
//    }
    
    override func viewDidLayoutSubviews() {
        
        let screenWidth = UIScreen.main.bounds.width
        let space = screenWidth/2
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mainLogo.topAnchor.constraint(equalTo: view.topAnchor,constant: space / 1.8 ),
            mainLogo.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor,constant: space / 4 ),
            mainLogo.widthAnchor.constraint(equalToConstant: space / 4),
            mainLogo.heightAnchor.constraint(equalTo: mainLogo.widthAnchor),
            loginTextField.topAnchor.constraint(equalTo: enteryLabel.bottomAnchor, constant: space / 3),
            loginTextField.leadingAnchor.constraint(equalTo: enteryLabel.leadingAnchor, constant: 20),
            loginTextField.trailingAnchor.constraint(equalTo: enteryLabel.trailingAnchor, constant: -20),
            loginTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 14),
            passwordTextField.leadingAnchor.constraint(equalTo: loginTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: loginTextField.heightAnchor),
            authorizationButton.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -25),
            authorizationButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            authorizationButton.widthAnchor.constraint(equalTo: enteryLabel.widthAnchor),
            authorizationButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor),
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
        enteryLabel.text = "Добро пожаловать в MyOffice"
        enteryLabel.numberOfLines = 3
        enteryLabel.textAlignment = .center
        enteryLabel.font = UIFont.italicSystemFont(ofSize: 32)
        enteryLabel.clipsToBounds = true
        view.addSubview(enteryLabel)
        
        loginTextField = UITextField()
        loginTextField.borderStyle = .none
        loginTextField.layer.backgroundColor = UIColor.white.cgColor
        loginTextField.layer.masksToBounds = false
        loginTextField.delegate = self
        loginTextField.layer.shadowColor = UIColor.gray.cgColor
        loginTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        loginTextField.layer.shadowOpacity = 1.0
        loginTextField.layer.shadowRadius = 0.0
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.placeholder = "Логин"
        loginTextField.attributedPlaceholder = NSAttributedString(string: "Логин", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        loginTextField.autocapitalizationType = .none
        loginTextField.textAlignment = .left
        view.addSubview(loginTextField)
        
        passwordTextField = UITextField()
        passwordTextField.borderStyle = .none
        passwordTextField.layer.backgroundColor = UIColor.white.cgColor
        passwordTextField.layer.masksToBounds = false
        passwordTextField.delegate = self
        passwordTextField.layer.shadowColor = UIColor.gray.cgColor
        passwordTextField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        passwordTextField.layer.shadowOpacity = 1.0
        passwordTextField.layer.shadowRadius = 0.0
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.placeholder = "Пароль"
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .left
        view.addSubview(passwordTextField)
        
        authorizationButton = UIButton()
        authorizationButton.setTitle("Присоединиться", for: .normal)
        authorizationButton.setTitleColor(.yellow, for: .normal)
        authorizationButton.setTitleColor(.lightGray, for: .highlighted)
        authorizationButton.layer.cornerRadius = 6
        authorizationButton.backgroundColor = .blue
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.addTarget(self, action:#selector(didAuthButtonTap), for: .touchUpInside)
        view.addSubview(authorizationButton)
                
    }
            
    @objc private func didAuthButtonTap() {
        if !(loginTextField.text! == "" || passwordTextField.text! == "") {
            let activityIndicator = UIActivityIndicatorView(style: .large)
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            activityIndicator.frame = view.bounds
            activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
            Auth.auth().signIn(withEmail: loginTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference()
                    self.data.users.removeAll()
                    self.oneOfUsers.coming.removeAll()
                    self.oneOfUsers.days.removeAll()
                    self.oneOfUsers.leaving.removeAll()
                    // TODO: Вынести в отдельную функцию
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        for (company, uids) in dict {
                            for (uid, _) in uids as! NSDictionary {
                                if hams == uid as? String {
                                    UserDefaults.standard.set(company, forKey: "company")
                                }
                            }
                        }
                        if Calendar.current.component(.weekday, from: Date()) == 2 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["weekHours": 0])
                        }
                        if Calendar.current.component(.day, from: Date()) == 1 {
                            base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work").updateChildValues(["monthHours": 0])
                        }
                        for (company, uids) in dict {
                            if company as? String == UserDefaults.standard.string(forKey: "company")! {
                                for (uid, categories) in uids as! NSDictionary {
                                    for (category, fields) in categories as! NSDictionary {
                                        if category as? String == "coming" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("comming").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.days.append(nameOfField as! String)
                                                    self.oneOfUsers.coming.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        if category as? String == "leaving" {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if !(self.dateNow(baseDate: nameOfField as! String)) {
                                                    base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("leaving").child(nameOfField as! String).removeValue()
                                                } else {
                                                    self.oneOfUsers.leaving.append(valueOfField as! String)
                                                }
                                            }
                                        }
                                        for (nameOfField, valueOfField) in fields as! NSDictionary {
                                            if nameOfField as? String == "admin" {
                                                if hams == uid as? String {
                                                    UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                }
                                                self.oneOfUsers.work.admin = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "check" {
                                                self.oneOfUsers.work.check = valueOfField as? Bool
                                                continue
                                            }
                                            if nameOfField as? String == "patronymic" {
                                                self.oneOfUsers.info.patronymic = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "wifi" {
                                                self.oneOfUsers.work.wifi = valueOfField as? String
                                                continue
                                            }
                                            if nameOfField as? String == "monthHours" {
                                                self.oneOfUsers.work.monthHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "totalHours" {
                                                self.oneOfUsers.work.totalHours = valueOfField as? Double
                                                continue
                                            }
                                            if nameOfField as? String == "weekHours" {
                                                self.oneOfUsers.work.weekHours = valueOfField as? Double
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
                                    self.oneOfUsers.coming.removeAll()
                                    self.oneOfUsers.days.removeAll()
                                    self.oneOfUsers.leaving.removeAll()
                                }
                            }
                        }

                        UserDefaults.standard.set(true, forKey: "autoSignIn") // Уже после того, как сделал автовход узнал про KeyChain, но также поджимают сроки написания программы
                        UserDefaults.standard.set(self.loginTextField.text?.lowercased(), forKey: "login")
                        UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                        activityIndicator.stopAnimating() // TODO: - Вовремя
                        let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                        MainScreenTabBarVC.data = self.data
                        MainScreenTabBarVC.modalPresentationStyle = .fullScreen
                        MainScreenTabBarVC.modalTransitionStyle = .flipHorizontal
                        self.present(MainScreenTabBarVC, animated: true, completion: nil)
                    })
                } else {
                    let alert = UIAlertController(title: "Вход не удался", message: "Автовход был очищен", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    // Очистка всего UserDefaults, если вход не был выполнен
                    if let appDomain = Bundle.main.bundleIdentifier {
                        UserDefaults.standard.removePersistentDomain(forName: appDomain)
                    }
                    activityIndicator.stopAnimating() // TODO: - Вовремя
                }
            })
        } else {
            if (loginTextField.text == "") {
                loginTextField.backgroundColor = .systemRed
                loginTextField.endEditing(true);
            }
            if (passwordTextField.text == "") {
                passwordTextField.backgroundColor = .systemRed
                passwordTextField.endEditing(true);
            }
            // Очистка всего UserDefaults, если вход не был выполнен
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
        }
    }
    
    private func dateNow(baseDate: String) -> Bool {
        var dateNow: String
        switch Calendar.current.component(.month, from: Date()) {
        case 1:
            dateNow = "\(Calendar.current.component(.day, from: Date())) january"
        case 2:
            dateNow = "\(Calendar.current.component(.day, from: Date())) february"
        case 3:
            dateNow = "\(Calendar.current.component(.day, from: Date())) march"
        case 4:
            dateNow = "\(Calendar.current.component(.day, from: Date())) april"
        case 5:
            dateNow = "\(Calendar.current.component(.day, from: Date())) may"
        case 6:
            dateNow = "\(Calendar.current.component(.day, from: Date())) june"
        case 7:
            dateNow = "\(Calendar.current.component(.day, from: Date())) july"
        case 8:
            dateNow = "\(Calendar.current.component(.day, from: Date())) august"
        case 9:
            dateNow = "\(Calendar.current.component(.day, from: Date())) september"
        case 10:
            dateNow = "\(Calendar.current.component(.day, from: Date())) october"
        case 11:
            dateNow = "\(Calendar.current.component(.day, from: Date())) november"
        case 12:
            dateNow = "\(Calendar.current.component(.day, from: Date())) december"
        default:
            dateNow = "0"
        }
        let separatedBaseDate = baseDate.components(separatedBy: [" "])
        let separatedNowDate = dateNow.components(separatedBy: [" "])

        if separatedBaseDate[1] == separatedNowDate[1] {
            if Int(separatedNowDate[0])! - Int(separatedBaseDate[0])! > 7 {
                return false
            }
        } else {
            return false
        }
        return true
        
    }
    
}

extension SignIn : UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordTextField {
            passwordTextField.backgroundColor = .white
        }
        if textField == loginTextField {
            loginTextField.backgroundColor = .white
        }
    }
    
}

