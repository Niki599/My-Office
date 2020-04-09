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
    
    /**
     Модель всех сотрудников
     */
    var data = Company.shared
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    
    // MARK: - Private Properties
    private var  companyView: UIView!
    private var companyTextField: UITextField!
    private var buttonAdmin: UIButton!
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
        
        navigationController?.navigationBar.backgroundColor = .black
        navigationItem.title = "Создание компании"
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        view.backgroundColor = .black
        
        companyView = UIView()
        companyView.layer.cornerRadius = 20
        companyView.backgroundColor = .white
        companyView.translatesAutoresizingMaskIntoConstraints = false
        companyView.alpha = 0.8
        view.addSubview(companyView)
        
        let companyLabel = UILabel()
        companyLabel.textColor = .black
        companyLabel.text = "Имя вашей компании"
        companyLabel.textAlignment = .center
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyView.addSubview(companyLabel)
        
        companyTextField = standartTextField("Имя компании")
        companyView.addSubview(companyTextField)
        
        buttonAdmin = UIButton(type: .custom)
        buttonAdmin.layer.borderWidth = 1
        buttonAdmin.layer.cornerRadius = 5
        buttonAdmin.backgroundColor = .red
        buttonAdmin.translatesAutoresizingMaskIntoConstraints = false
        buttonAdmin.addTarget(nil, action: #selector(didTapRadioButton(_:)), for: .touchUpInside)
        companyView.addSubview(buttonAdmin)
        
        let infoView = UIView()
        infoView.layer.cornerRadius = 20
        infoView.backgroundColor = .white
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.alpha = 0.8
        view.addSubview(infoView)
        
        let infoLabel = UILabel()
        infoLabel.textColor = .black
        infoLabel.text = "Информация для отображения в таблице"
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(infoLabel)
        
        nameTextField = standartTextField("Имя")
        
        surnameTextField = standartTextField("Фамилия")
        
        dateTextField = standartTextField("Дата")
        
        emailTextField = standartTextField("Почта")
        
        phoneTextField = standartTextField("Телефон")
        
        passportTextField = standartTextField("Паспорт")
        
        passwordTextField = standartTextField("Пароль")
        
        patronymicTextField = standartTextField("Отчество")
        
        wifiTextField = standartTextField("Wi-Fi")
        
        let firstStackViewInfo = UIStackView(arrangedSubviews: [emailTextField, nameTextField, surnameTextField, patronymicTextField, dateTextField, phoneTextField])
        firstStackViewInfo.axis = .vertical
        firstStackViewInfo.distribution = .fillEqually
        firstStackViewInfo.spacing = 15
        firstStackViewInfo.alignment = .center
        firstStackViewInfo.backgroundColor = .black
        firstStackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(firstStackViewInfo)
        
        let secondStackViewInfo = UIStackView(arrangedSubviews: [passwordTextField, passportTextField, wifiTextField])
        secondStackViewInfo.axis = .vertical
        secondStackViewInfo.distribution = .fillEqually
        secondStackViewInfo.spacing = 15
        secondStackViewInfo.alignment = .center
        secondStackViewInfo.backgroundColor = .black
        secondStackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(secondStackViewInfo)

        let nextButton = UIButton()
        nextButton.setTitle("Продолжить", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.setTitleColor(.lightGray, for: .highlighted)
        nextButton.backgroundColor = .black
        nextButton.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action:#selector(didNextButtonTap), for: .touchUpInside)
        infoView.addSubview(nextButton)
        
        if typeOfSignUp {
            companyLabel.isHidden = false
            companyTextField.isHidden = false
            buttonAdmin.isHidden = true
        } else {
            companyLabel.isHidden = true
            companyTextField.isHidden = true
            buttonAdmin.isHidden = false
        }
        
        constraints = [
            companyView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            companyView.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 20),
            companyView.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            companyView.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            companyView.heightAnchor.constraint(equalToConstant: screenHeight / 6.5),
            
            companyTextField.bottomAnchor.constraint(equalTo: companyView.bottomAnchor, constant: -26),
            companyTextField.leadingAnchor.constraint(equalTo: companyView.leadingAnchor, constant: 10),
            companyTextField.trailingAnchor.constraint(equalTo: companyView.trailingAnchor, constant: -10),
            companyTextField.heightAnchor.constraint(equalToConstant: 25),
            
            companyLabel.bottomAnchor.constraint(equalTo: companyTextField.topAnchor, constant: -10),
            companyLabel.leadingAnchor.constraint(equalTo: companyTextField.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: companyTextField.trailingAnchor),
            
            buttonAdmin.centerXAnchor.constraint(equalTo: companyView.safeArea.centerXAnchor),
            buttonAdmin.centerYAnchor.constraint(equalTo: companyView.safeArea.centerYAnchor),
            buttonAdmin.widthAnchor.constraint(equalToConstant: 45),
            buttonAdmin.heightAnchor.constraint(equalToConstant: 45),
            
            infoView.topAnchor.constraint(equalTo: companyView.bottomAnchor, constant: 10),
            infoView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            infoView.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            infoView.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            infoView.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            infoLabel.heightAnchor.constraint(equalToConstant: 30),
            
            firstStackViewInfo.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 15),
            firstStackViewInfo.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 15),
            firstStackViewInfo.widthAnchor.constraint(equalToConstant: screenWidth / 2.5),
            firstStackViewInfo.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -60),
            
            nameTextField.leadingAnchor.constraint(equalTo: firstStackViewInfo.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor),
            
            surnameTextField.leadingAnchor.constraint(equalTo: firstStackViewInfo.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor),
            
            dateTextField.leadingAnchor.constraint(equalTo: firstStackViewInfo.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor),
            
            emailTextField.leadingAnchor.constraint(equalTo: firstStackViewInfo.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor),
            
            phoneTextField.leadingAnchor.constraint(equalTo: firstStackViewInfo.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor),
            
            patronymicTextField.leadingAnchor.constraint(equalTo: firstStackViewInfo.leadingAnchor),
            patronymicTextField.trailingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor),
            
            secondStackViewInfo.topAnchor.constraint(equalTo: firstStackViewInfo.topAnchor),
            secondStackViewInfo.leadingAnchor.constraint(equalTo: firstStackViewInfo.trailingAnchor, constant: 15),
            secondStackViewInfo.widthAnchor.constraint(equalToConstant: screenWidth / 2.5),
            secondStackViewInfo.bottomAnchor.constraint(equalTo: surnameTextField.bottomAnchor),
            
            passwordTextField.leadingAnchor.constraint(equalTo: secondStackViewInfo.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: secondStackViewInfo.trailingAnchor),
            
            passportTextField.leadingAnchor.constraint(equalTo: secondStackViewInfo.leadingAnchor),
            passportTextField.trailingAnchor.constraint(equalTo: secondStackViewInfo.trailingAnchor),
            
            wifiTextField.leadingAnchor.constraint(equalTo: secondStackViewInfo.leadingAnchor),
            wifiTextField.trailingAnchor.constraint(equalTo: secondStackViewInfo.trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: firstStackViewInfo.bottomAnchor, constant: 10),
            nextButton.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            nextButton.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10),
            
        ]
    }
    
    func standartTextField(_ placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        textField.textAlignment = .center
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 3
        textField.delegate = self
        textField.placeholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    @objc private func didTapRadioButton(_ sender: UIButton) {
        if (sender.isSelected) {
            sender.backgroundColor = .red
            sender.isSelected = false
            return
        } else {
            sender.isSelected = true
            sender.backgroundColor = .green
        }
    }
    
    @objc private func didNextButtonTap() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
        if typeOfSignUp {
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (result, error) in
                let hams = Auth.auth().currentUser?.uid
                let base = Database.database().reference().child(self.companyTextField.text!).child(hams!)
                let info = base.child("info")
                let work = base.child("work")
                info.updateChildValues(["name": self.nameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!.lowercased(), "pass": self.passportTextField.text!, "date": self.dateTextField.text!, "phone": self.phoneTextField.text!, "patronymic": self.patronymicTextField.text!])
                // TODO: - Cчитывать Wi-Fi
                work.updateChildValues(["admin": true, "check": false, "monthHours": 0, "weekHours": 0, "totalHours": 0, "wifi": self.wifiTextField.text!])
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                    if user != nil {
                        let hams = Auth.auth().currentUser?.uid
                        let base = Database.database().reference().child((self.companyTextField.text!))
                        self.data.users.removeAll()
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
                        // Очистка всего UserDefaults, если вход не был выполнен
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
                let info = base.child("info")
                let work = base.child("work")
                info.updateChildValues(["name": self.nameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!.lowercased(), "pass": self.passportTextField.text!, "date": self.dateTextField.text!, "phone": self.phoneTextField.text!, "patronymic": self.patronymicTextField.text!])
                work.updateChildValues(["admin": self.buttonAdmin.isSelected, "check": false, "monthHours": 0, "weekHours": 0, "totalHours": 0, "wifi": self.wifiTextField.text!])
                self.dismiss(animated: true, completion: nil)
            }
        }
        activityIndicator.stopAnimating() // TODO: - Вовремя
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
