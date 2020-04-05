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
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser(), days: DaysOfWeek(), coming: ComingTime(), leaving: LeavingTime())
    
    // MARK: - Private Properties
    private var  companyView: UIView!
    private var companyTextField: UITextField!
    private var buttonAdmin: UIButton!
    private var nameTextField: UITextField!
    private var surnameTextField: UITextField!
    private var dateTextField: UITextField!
    private var emailTextField: UITextField!
    private var phoneTextField: UITextField!
    private var passTextField: UITextField!
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
        
        passTextField = standartTextField("Паспорт")
        
        let stackViewInfo = UIStackView(arrangedSubviews: [emailTextField, nameTextField, surnameTextField, dateTextField, phoneTextField, passTextField])
        stackViewInfo.axis = .vertical
        stackViewInfo.distribution = .fillEqually
        stackViewInfo.spacing = 15
        stackViewInfo.alignment = .center
        stackViewInfo.backgroundColor = .black
        stackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(stackViewInfo)
        
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
            companyView.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
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
            infoView.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
            infoView.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            
            stackViewInfo.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 15),
            stackViewInfo.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            stackViewInfo.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            stackViewInfo.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -60),
            
            nameTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            surnameTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            dateTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            emailTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            phoneTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            passTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            passTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            nextButton.topAnchor.constraint(equalTo: stackViewInfo.bottomAnchor, constant: 10),
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
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.phoneTextField.text!) { (result, error) in
                let hams = Auth.auth().currentUser?.uid
                let base = Database.database().reference().child(self.companyTextField.text!).child(hams!)
                let info = base.child("info")
                let work = base.child("work")
                info.updateChildValues(["name": self.nameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!.lowercased(), "pass": self.passTextField.text!, "date": self.dateTextField.text!, "phone": self.phoneTextField.text!])
                // TODO: - Добавить patronymic
                // TODO: - Добавить Wi-Fi и считывать его
                work.updateChildValues(["admin": true, "check": false, "monthHours": 0, "weekHours": 0, "totalHours": 0])
                Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.phoneTextField.text!) { (user, error) in
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
                                        if nameOfField as? String == "coming" {
                                            self.oneOfUsers.work.coming = valueOfField as? String
                                            continue
                                        }
                                        if nameOfField as? String == "patronymic" {
                                            self.oneOfUsers.info.patronymic = valueOfField as? String
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
                            
                            UserDefaults.standard.set(true, forKey: "autoSignIn")
                            UserDefaults.standard.set(self.emailTextField.text!.lowercased(), forKey: "login")
                            UserDefaults.standard.set(self.phoneTextField.text, forKey: "password")
                            let MainScreenTabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "MainScreenTabBar") as! MainScreenTabBar
                            MainScreenTabBarVC.data = self.data
                            MainScreenTabBarVC.modalPresentationStyle = .fullScreen
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
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.phoneTextField.text!) { (result, error) in
                let hams = Auth.auth().currentUser?.uid
                let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!)
                let info = base.child("info")
                let work = base.child("work")
                info.updateChildValues(["name": self.nameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!.lowercased(), "pass": self.passTextField.text!, "date": self.dateTextField.text!, "phone": self.phoneTextField.text!])
                // TODO: - Добавить patronymic
                work.updateChildValues(["admin": self.buttonAdmin.isSelected, "check": false, "monthHours": 0, "weekHours": 0, "totalHours": 0])
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
