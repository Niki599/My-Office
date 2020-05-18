//
//  SignUp.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 11/02/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase

class SignUp: UIViewController {
    
    // MARK: - Public Properties
    
    /**
     Если true, то регистрируют компанию, false -- человека
     Если регистрируют человека, то добавим radioButton, иначе -- нет
     */
    var typeOfSignUp: Bool!
    var endOfEditing: Bool = false
    /**
     Модель всех сотрудников
     */
    var data = Company.shared
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    
    // MARK: - Private Properties
    private var companyView: UIView!
    private var infoView: UIView!
    private var companyTextField: UITextField!
    private var buttonAdmin: UIButton!
    private var labelAdmin: UILabel!
    private var nameTextField: UITextField!
    private var surnameTextField: UITextField!
    private var dateTextField: UITextField!
    private var emailTextField: UITextField!
    private var phoneTextField: UITextField!
    private var passportTextField: UITextField!
    private var passwordTextField: UITextField!
    private var patronymicTextField: UITextField!
    private var wifiTextField: UITextField!
    private var constraints: [NSLayoutConstraint]!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //Тап по экрану, чтобы спрятать клаву
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        navigationController?.navigationBar.backgroundColor = .gray
        navigationItem.title = "Создание филиала"
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        view.backgroundColor = .white
        
        companyView = UIView()
        companyView.backgroundColor = .white
        companyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companyView)
        
        let companyLabel = UILabel()
        companyLabel.textColor = .black
        companyLabel.text = "Филиал"
        companyLabel.font = UIFont.systemFont(ofSize: 18)
        companyLabel.textAlignment = .center
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyView.addSubview(companyLabel)
        
        companyTextField = standartTextField("Название филиала")
        companyView.addSubview(companyTextField)
        
        infoView = UIView()
        infoView.backgroundColor = .white
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.alpha = 0
        view.addSubview(infoView)
        
        labelAdmin = UILabel()
        labelAdmin.textColor = .black
        labelAdmin.text = "Права администратора"
        labelAdmin.font = UIFont.systemFont(ofSize: 15)
        labelAdmin.numberOfLines = 0
        labelAdmin.textAlignment = .left
        labelAdmin.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(labelAdmin)
        
        buttonAdmin = UIButton(type: .custom)
        buttonAdmin.layer.borderWidth = 1
        buttonAdmin.setImage(UIImage(named: "checkBox.png"), for: .selected)
        buttonAdmin.layer.cornerRadius = 5
        buttonAdmin.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        buttonAdmin.backgroundColor = .none
        buttonAdmin.translatesAutoresizingMaskIntoConstraints = false
        buttonAdmin.addTarget(nil, action: #selector(didTapRadioButton(_:)), for: .touchUpInside)
        infoView.addSubview(buttonAdmin)
        
        let infoLabel = UILabel()
        infoLabel.textColor = .black
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(infoLabel)
        
        nameTextField = standartTextField("Имя")
        infoView.addSubview(nameTextField)

        surnameTextField = standartTextField("Фамилия")
        infoView.addSubview(surnameTextField)

        dateTextField = standartTextField("Дата")
        dateTextField.keyboardType = .numbersAndPunctuation
        infoView.addSubview(dateTextField)

        emailTextField = standartTextField("Почта")
        emailTextField.keyboardType = .emailAddress
        infoView.addSubview(emailTextField)

        phoneTextField = standartTextField("Телефон")
        phoneTextField.keyboardType = .numberPad
        infoView.addSubview(phoneTextField)

        passportTextField = standartTextField("Паспорт")
        passportTextField.keyboardType = .numberPad
        infoView.addSubview(passportTextField)

        passwordTextField = standartTextField("Пароль")
        infoView.addSubview(passwordTextField)

        patronymicTextField = standartTextField("Отчество")
        infoView.addSubview(patronymicTextField)

        wifiTextField = standartTextField("Wi-Fi")
        wifiTextField.keyboardType = .numbersAndPunctuation
        infoView.addSubview(wifiTextField)

        let nextButton = UIButton()
        nextButton.setTitle("Далее", for: .normal)
        nextButton.setTitleColor(.yellow, for: .normal)
        nextButton.setTitleColor(.lightGray, for: .highlighted)
        nextButton.backgroundColor = .blue
        nextButton.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        nextButton.layer.cornerRadius = 6
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action:#selector(didNextButtonTap), for: .touchUpInside)
        view.addSubview(nextButton)
        
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(didBackButtonTap), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(imageLiteralResourceName: "arrowLeft.png"), for: .normal)
        view.addSubview(backButton)
        
        if typeOfSignUp {
            infoLabel.text = "Руководитель филиала"
            buttonAdmin.isHidden = true
            labelAdmin.isHidden = true
            backButton.isHidden = true
        } else {
            //            Регистрация человека
            endOfEditing = true
            self.companyView.alpha = 0.0
            self.infoView.alpha = 1
            infoLabel.text = "Новый сотрудник"
            buttonAdmin.isHidden = false
            labelAdmin.isHidden = false
            backButton.isHidden = false
        }
        
        constraints = [
            
            backButton.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            companyView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            companyView.centerYAnchor.constraint(equalTo: view.safeArea.centerYAnchor),
            companyView.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
            companyView.heightAnchor.constraint(equalToConstant: screenHeight / 5.0),
            
            companyTextField.centerYAnchor.constraint(equalTo: companyView.centerYAnchor),
            companyTextField.centerXAnchor.constraint(equalTo: companyView.centerXAnchor),
            companyTextField.heightAnchor.constraint(equalToConstant: 44),
            companyTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.8),
            
            companyLabel.bottomAnchor.constraint(equalTo: companyTextField.topAnchor, constant: -10),
            companyLabel.centerXAnchor.constraint(equalTo: companyView.centerXAnchor),
                        
            infoView.heightAnchor.constraint(equalToConstant: screenHeight / 1.4),
            infoView.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
            infoView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            infoView.centerYAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -100),
            
            infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor),
            infoLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            
            nameTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            nameTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            nameTextField.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            
            surnameTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            surnameTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            surnameTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 3),
            
            patronymicTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            patronymicTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            patronymicTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            patronymicTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 3),
            
            dateTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            dateTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            dateTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            dateTextField.topAnchor.constraint(equalTo: patronymicTextField.bottomAnchor, constant: 3),
            
            passportTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            passportTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            passportTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            passportTextField.topAnchor.constraint(equalTo: dateTextField.bottomAnchor, constant: 3),
            
            phoneTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            phoneTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            phoneTextField.topAnchor.constraint(equalTo: passportTextField.bottomAnchor, constant: 3),
                        
            wifiTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            wifiTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            wifiTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            wifiTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 3),

            emailTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            emailTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            emailTextField.topAnchor.constraint(equalTo: wifiTextField.bottomAnchor, constant: 3),
            
            passwordTextField.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            passwordTextField.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.3),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 3),
            
            labelAdmin.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            labelAdmin.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            labelAdmin.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 13),
            labelAdmin.widthAnchor.constraint(equalToConstant: screenWidth / 1.3 / 1.7),
            
            buttonAdmin.topAnchor.constraint(equalTo: labelAdmin.topAnchor),
            buttonAdmin.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            buttonAdmin.heightAnchor.constraint(equalToConstant: screenHeight / 1.4 / 14),
            buttonAdmin.widthAnchor.constraint(equalToConstant: screenHeight / 1.4 / 14),
                        
            nextButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -20),
            nextButton.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
            nextButton.heightAnchor.constraint(equalToConstant: 44)
            
        ]
    }
    
    func standartTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowColor = UIColor.gray.cgColor
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
        textField.textAlignment = .center
        textField.delegate = self
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    @objc private func didBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRadioButton(_ sender: UIButton) {
        if (sender.isSelected) {
            sender.backgroundColor = .none
            sender.isSelected = false
            return
        } else {
            sender.isSelected = true
//            sender.backgroundColor = .green
        }
    }
    
    @objc private func didNextButtonTap() {
        if endOfEditing {
            if (nameTextField.text! != "" || surnameTextField.text! != "" || dateTextField.text! != "" || emailTextField.text! != "" || phoneTextField.text! != "" || passportTextField.text! != "" || passwordTextField.text! != "" || patronymicTextField.text! != "" || wifiTextField.text! != "") {
                let activityIndicator = UIActivityIndicatorView(style: .large)
                view.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                activityIndicator.frame = view.bounds
                activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
                if typeOfSignUp {
                    Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (result, error) in
                        let hams = Auth.auth().currentUser?.uid
                        let base = Database.database().reference().child(self.companyTextField.text!).child(hams!)
                        let baseComing = base.child("coming")
                        let info = base.child("info")
                        let work = base.child("work")
                        info.updateChildValues(["name": self.nameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!.lowercased(), "pass": self.passportTextField.text!, "date": self.dateTextField.text!, "phone": self.phoneTextField.text!, "patronymic": self.patronymicTextField.text!])
                        work.updateChildValues(["admin": true, "check": false, "monthHours": 0, "weekHours": 0, "totalHours": 0, "wifi": self.wifiTextField.text!])
                        switch Calendar.current.component(.month, from: Date()) {
                        case 1:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) января": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 2:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) февраля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 3:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) марта": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 4:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) апреля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 5:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) мая": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 6:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июня": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 7:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 8:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) августа": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 9:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) сентября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 10:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) октября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 11:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) ноября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 12:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) декабря": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        default:
                            print("Быть такого не может")
                        }

                        Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                            if user != nil {
                                let hams = Auth.auth().currentUser?.uid
                                let base = Database.database().reference().child((self.companyTextField.text!))
                                self.data.users.removeAll()
                                self.oneOfUsers.coming.removeAll()
                                self.oneOfUsers.days.removeAll()
                                self.oneOfUsers.leaving.removeAll()
                                // TODO: Вынести в отдельную функцию
                                base.observe(.value, with:  { (snapshot) in
                                    guard let value = snapshot.value, snapshot.exists() else { return }
                                    let dict: NSDictionary = value as! NSDictionary
                                    for (uid, categories) in dict as! NSDictionary {
                                        for (category, fields) in categories as! NSDictionary {
                                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                                if nameOfField as? String == "admin" {
                                                    // Всегда true
                                                    if hams == uid as? String {
                                                        UserDefaults.standard.set(valueOfField, forKey: "admin")
                                                        UserDefaults.standard.set((self.companyTextField.text!), forKey: "company")
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
                                    }
                                    
                                    UserDefaults.standard.set(true, forKey: "autoSignIn")
                                    UserDefaults.standard.set(self.emailTextField.text!.lowercased(), forKey: "login")
                                    UserDefaults.standard.set(self.passwordTextField.text, forKey: "password")
                                    let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                                    MainScreenTabBarVC.data = self.data
                                    MainScreenTabBarVC.modalPresentationStyle = .fullScreen
                                    MainScreenTabBarVC.modalTransitionStyle = .flipHorizontal
                                    self.present(MainScreenTabBarVC, animated: true, completion: nil)
                                })
                            }
                            else {
                                /**
                                 Очистка всего UserDefaults, если вход не был выполнен
                                 */
                                if let appDomain = Bundle.main.bundleIdentifier {
                                    UserDefaults.standard.removePersistentDomain(forName: appDomain)
                                }
                            }
                        }
                    }
                } else {
                    Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (result, error) in
                        let hams = Auth.auth().currentUser?.uid
                        let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!)
                        let baseComing = base.child("coming")
                        let baseLeaving = base.child("leaving")
                        let info = base.child("info")
                        let work = base.child("work")
                        info.updateChildValues(["name": self.nameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!.lowercased(), "pass": self.passportTextField.text!, "date": self.dateTextField.text!, "phone": self.phoneTextField.text!, "patronymic": self.patronymicTextField.text!])
                        work.updateChildValues(["admin": self.buttonAdmin.isSelected, "check": false, "monthHours": 0, "weekHours": 0, "totalHours": 0, "wifi": self.wifiTextField.text!])
                        switch Calendar.current.component(.month, from: Date()) {
                        case 1:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) января": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 2:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) февраля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 3:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) марта": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 4:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) апреля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 5:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) мая": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 6:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июня": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 7:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 8:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) августа": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 9:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) сентября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 10:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) октября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 11:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) ноября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 12:
                            baseComing.updateChildValues(["\(Calendar.current.component(.day, from: Date())) декабря": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        default:
                            print("Быть такого не может")
                        }

                        self.dismiss(animated: true, completion: nil)
                    }
                }
                activityIndicator.stopAnimating() // TODO: - Вовремя
            }
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                self.companyView.alpha = 0.0
                self.companyView.center.y = 200
            }, completion: { (didEnding) in
                UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut, animations: {
                    self.infoView.alpha = 1
                    self.infoView.center.y = UIScreen.main.bounds.height / 2.0
                }, completion: { (didEnding) in
                    self.endOfEditing = true
                })
            })
        }
    }
    
}

extension SignUp: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //        var frame = self.viewCompany.frame
        //        frame.origin.y = 800
        //        UIView.animate(withDuration: 1.3, delay: 0, options: .curveEaseOut, animations: {
        //            self.viewCompany.frame = frame
        //        }, completion: nil)
    }
    
}
