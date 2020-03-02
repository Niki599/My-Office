//
//  ProfileEmployeer.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 21/01/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileEmployeer: UIViewController {
           
    // MARK: - Public Properties
    
    var data: Company!
    
    // MARK: - Private Properties
    
    private var constraints: [NSLayoutConstraint]!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard UserDefaults.standard.string(forKey: "login") != nil else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard UserDefaults.standard.string(forKey: "login") != nil else {
            self.navigationController?.popViewController(animated: false)
            return
        }
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        view.backgroundColor = .white
        let title = UILabel()
        title.text = "Информация о сотруднике"
        title.font = UIFont(name: "Roboto-Regular", size: 14)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        
        let deleteAccButton = UIButton()
        deleteAccButton.addTarget(self, action: #selector(didDeleteAccButtonTap), for: .touchUpInside)
        deleteAccButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccButton.setImage(UIImage(systemName: "xmark")!.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        deleteAccButton.setTitleColor(.black, for: .normal)
        view.addSubview(deleteAccButton)
        
        let image = UIImageView(image: UIImage(named: "employee.png"))//Берем с базы
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        let labelName = UILabel()
        labelName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelName.font.withSize(6)
        labelName.numberOfLines = 0
        labelName.lineBreakMode = .byWordWrapping
        labelName.text = "Ф.И.О:"
        labelName.textAlignment = .left
        labelName.translatesAutoresizingMaskIntoConstraints = false
        
        let labelFullName = UILabel()
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login") {
                labelFullName.text = "\(user.info.name!) \(user.info.surname!)"
            }
        }
        labelFullName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelFullName.numberOfLines = 0
        labelFullName.font.withSize(8)
        labelFullName.translatesAutoresizingMaskIntoConstraints = false
        
        
        let labelBirthday = UILabel()
        labelBirthday.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelBirthday.font = UIFont(name: "Roboto-Regular", size: 6)
        labelBirthday.numberOfLines = 0
        labelBirthday.lineBreakMode = .byWordWrapping
        labelBirthday.text = "Дата рождения:"
        labelBirthday.textAlignment = .left
        labelBirthday.translatesAutoresizingMaskIntoConstraints = false
        
        let labelBirthdayDate = UILabel()
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login") {
                labelBirthdayDate.text = String(user.info.date!)
            }
        }
        labelBirthdayDate.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelBirthdayDate.font = UIFont(name: "Roboto-Regular", size: 8)
        labelBirthdayDate.translatesAutoresizingMaskIntoConstraints = false
        
        let labelPhone = UILabel()
        labelPhone.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelPhone.font = UIFont(name: "Roboto-Regular", size: 6)
        labelPhone.numberOfLines = 0
        labelPhone.lineBreakMode = .byWordWrapping
        labelPhone.text = "Номер телефона:"
        labelPhone.textAlignment = .left
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        
        let labelPhoneNumber = UILabel()
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login") {
                labelPhoneNumber.text = String(user.info.phone!)
            }
        }
        labelPhoneNumber.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelPhoneNumber.font = UIFont(name: "Roboto-Regular", size: 8)
        labelPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
        
        let labelPass = UILabel()
        labelPass.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelPass.font.withSize(6)
        labelPass.numberOfLines = 0
        labelPass.lineBreakMode = .byWordWrapping
        labelPass.text = "Серия и номер пасспорта:"
        labelPass.textAlignment = .left
        labelPass.translatesAutoresizingMaskIntoConstraints = false
        
        let labelNumberOfPass = UILabel()
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login")! {
                labelNumberOfPass.text = String(user.info.pass!)
            }
        }
        labelNumberOfPass.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNumberOfPass.font.withSize(8)
        labelNumberOfPass.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonExit = UIButton()
        buttonExit.setTitle("Выход", for: .normal)
        buttonExit.setTitleColor(.red, for: .normal)
        buttonExit.setTitleColor(UIColor(red: 255, green: 0, blue: 0, alpha: 0.5), for: .highlighted)
        buttonExit.addTarget(nil, action: #selector(exitAction), for: .touchUpInside)
        buttonExit.backgroundColor = .none
        buttonExit.translatesAutoresizingMaskIntoConstraints = false
        buttonExit.clipsToBounds = true
        view.addSubview(buttonExit)
        
        let stackViewName = UIStackView(arrangedSubviews: [labelName, labelFullName])
        stackViewName.axis = .horizontal
        stackViewName.distribution = .fill
        stackViewName.spacing = 10
        stackViewName.alignment = .center
        stackViewName.backgroundColor = .black
        stackViewName.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewName)
        
        let stackViewBirthday = UIStackView(arrangedSubviews: [labelBirthday, labelBirthdayDate])
        stackViewBirthday.axis = .horizontal
        stackViewBirthday.distribution = .fill
        stackViewBirthday.spacing = 10
        stackViewBirthday.alignment = .center
        stackViewBirthday.backgroundColor = .black
        stackViewBirthday.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewBirthday)
        
        let stackViewPhone = UIStackView(arrangedSubviews: [labelPhone, labelPhoneNumber])
        stackViewPhone.axis = .horizontal
        stackViewPhone.distribution = .fill
        stackViewPhone.spacing = 10
        stackViewPhone.alignment = .center
        stackViewPhone.backgroundColor = .black
        stackViewPhone.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewPhone)
        
        let stackViewPass = UIStackView(arrangedSubviews: [labelPass, labelNumberOfPass])
        stackViewPass.axis = .horizontal
        stackViewPass.distribution = .fill
        stackViewPass.spacing = 10
        stackViewPass.alignment = .center
        stackViewPass.backgroundColor = .black
        stackViewPass.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewPass)
        
        let groupStackViewInfo = UIStackView(arrangedSubviews: [stackViewName, stackViewBirthday, stackViewPhone, stackViewPass])
        groupStackViewInfo.axis = .vertical
        groupStackViewInfo.distribution = .equalSpacing
        groupStackViewInfo.spacing = 10
        groupStackViewInfo.alignment = .center
        groupStackViewInfo.backgroundColor = .black
        groupStackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(groupStackViewInfo)
        
        constraints = [
            title.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            
            deleteAccButton.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 20),
            deleteAccButton.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 60),
            
            labelNumberOfPass.topAnchor.constraint(equalTo: stackViewPass.topAnchor),
            
            stackViewName.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewName.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewBirthday.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewBirthday.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewPhone.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewPhone.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewPass.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewPass.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            groupStackViewInfo.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            groupStackViewInfo.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 15),
            groupStackViewInfo.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -15),
            
            buttonExit.topAnchor.constraint(equalTo: groupStackViewInfo.bottomAnchor, constant: 20),
            buttonExit.heightAnchor.constraint(equalToConstant: 40),
            buttonExit.widthAnchor.constraint(equalToConstant: 60),
            buttonExit.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
        ]
    }
    
    @objc private func exitAction() {
        
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "dataAvailability")
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            self.navigationController?.popViewController(animated: true)
//          dismissViewControllerAnimated(true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: \(signOutError)")
        }
        
    }
    
    @objc private func didDeleteAccButtonTap() {
        
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
            _ = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(String( Auth.auth().currentUser!.uid)).removeValue()
            Auth.auth().currentUser?.delete(completion: { (error) in
                self.navigationController?.popViewController(animated: true)
            })
        }
        
    }
    
}
