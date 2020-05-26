//
//  ProfileEmployeer.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 21/01/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase

class ProfileEmployeer: UIViewController {
           
    // MARK: - Public Properties
    
    var data: Company!
    var typeOfShowVC = true
    
    // MARK: - Private Properties
    
    private var constraints: [NSLayoutConstraint]!
    private var labelFullName = UILabel()
    private var labelBirthdayDate = UILabel()
    private var labelPhoneNumber = UILabel()
    private var labelNumberOfPass = UILabel()
    private var labelStringPassAdmin = UILabel()
    private var deleteAccButton = UIButton()
    private var buttonExit = UIButton()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard UserDefaults.standard.string(forKey: "login") != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Initializers
        
    init(emailUser: String, data: Company) {
        super.init(nibName: nil, bundle: nil)
        self.data = data
        typeOfShowVC = false
        for user in data.users {
            if user.info.email == emailUser {
                labelFullName.text = "\(user.info.name!) \(user.info.surname!) \(user.info.patronymic!)"
                labelBirthdayDate.text = "\(user.info.date!)"
                labelPhoneNumber.text = "\(user.info.phone!)"
                labelNumberOfPass.text = "\(user.info.pass!)"
                if user.work.admin! {
                    labelStringPassAdmin.text = "Обладает правами администратора"
                    labelStringPassAdmin.textColor = .systemGreen
                } else {
                    labelStringPassAdmin.text = "Не обладает правами администратора"
                    labelStringPassAdmin.textColor = .systemRed
                }
                buttonExit.isHidden = true
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        
        deleteAccButton = UIButton()
        deleteAccButton.addTarget(self, action: #selector(didDeleteAccButtonTap), for: .touchUpInside)
        deleteAccButton.translatesAutoresizingMaskIntoConstraints = false
        deleteAccButton.setImage(UIImage(systemName: "xmark")!.resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        deleteAccButton.setTitleColor(.black, for: .normal)
        view.addSubview(deleteAccButton)
        
        let image = UIImageView(image: UIImage(named: "employee.png"))
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
        
        labelNumberOfPass.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNumberOfPass.font.withSize(8)
        labelNumberOfPass.translatesAutoresizingMaskIntoConstraints = false
        
        buttonExit.setTitle("Выход", for: .normal)
        buttonExit.setTitleColor(.red, for: .normal)
        buttonExit.setTitleColor(UIColor(red: 255, green: 0, blue: 0, alpha: 0.5), for: .highlighted)
        buttonExit.addTarget(nil, action: #selector(exitAction), for: .touchUpInside)
        buttonExit.backgroundColor = .none
        buttonExit.translatesAutoresizingMaskIntoConstraints = false
        buttonExit.clipsToBounds = true
        view.addSubview(buttonExit)
        
        let labelPassAdmin = UILabel()
        labelPassAdmin.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelPassAdmin.font.withSize(6)
        labelPassAdmin.numberOfLines = 0
        labelPassAdmin.lineBreakMode = .byWordWrapping
        labelPassAdmin.text = "Права администратора:"
        labelPassAdmin.textAlignment = .left
        labelPassAdmin.translatesAutoresizingMaskIntoConstraints = false
        
        labelStringPassAdmin.font = UIFont(name: "Roboto-Regular", size: 8)
        labelStringPassAdmin.translatesAutoresizingMaskIntoConstraints = false
        labelStringPassAdmin.numberOfLines = 0
        labelStringPassAdmin.lineBreakMode = .byWordWrapping
        
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
        
        let stackViewPassAdmin = UIStackView(arrangedSubviews: [labelPassAdmin, labelStringPassAdmin])
        stackViewPassAdmin.axis = .horizontal
        stackViewPassAdmin.distribution = .fill
        stackViewPassAdmin.spacing = 10
        stackViewPassAdmin.alignment = .center
        stackViewPassAdmin.backgroundColor = .black
        stackViewPassAdmin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewPassAdmin)
        
        let groupStackViewInfo = UIStackView(arrangedSubviews: [stackViewName, stackViewBirthday, stackViewPhone, stackViewPass, stackViewPassAdmin])
        groupStackViewInfo.axis = .vertical
        groupStackViewInfo.distribution = .equalSpacing
        groupStackViewInfo.spacing = 10
        groupStackViewInfo.alignment = .center
        groupStackViewInfo.backgroundColor = .black
        groupStackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(groupStackViewInfo)
        
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(didBackButtonTap), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(imageLiteralResourceName: "arrowLeft.png"), for: .normal)
        view.addSubview(backButton)
        
        if typeOfShowVC {
            for user in data.users {
                if user.info.email == UserDefaults.standard.string(forKey: "login") {
                    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
                    rightSwipe.direction = .right
                    self.view.addGestureRecognizer(rightSwipe)
                    labelFullName.text = "\(user.info.name!) \(user.info.surname!)"
                    labelBirthdayDate.text = "\(user.info.date!)"
                    labelPhoneNumber.text = "\(user.info.phone!)"
                    labelNumberOfPass.text = "\(user.info.pass!)"
                    if user.work.admin! {
                        labelStringPassAdmin.text = "Обладает правами администратора"
                        labelStringPassAdmin.textColor = .systemGreen
                    } else {
                        labelStringPassAdmin.text = "Не обладает правами администратора"
                        labelStringPassAdmin.textColor = .systemRed
                    }
                    backButton.isHidden = true
                }
            }
        } else {
            deleteAccButton.isHidden = true
        }
        
        constraints = [
            title.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            
            deleteAccButton.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            deleteAccButton.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            
            backButton.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: UIScreen.main.bounds.height / 6.0),
            
            labelNumberOfPass.topAnchor.constraint(equalTo: stackViewPass.topAnchor),
            
            stackViewName.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewName.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewBirthday.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewBirthday.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewPhone.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewPhone.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewPass.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewPass.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            stackViewPassAdmin.leadingAnchor.constraint(equalTo: groupStackViewInfo.leadingAnchor),
            stackViewPassAdmin.trailingAnchor.constraint(equalTo: groupStackViewInfo.trailingAnchor),
            
            groupStackViewInfo.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            groupStackViewInfo.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.2),
            groupStackViewInfo.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            
            buttonExit.topAnchor.constraint(equalTo: groupStackViewInfo.bottomAnchor, constant: 20),
            buttonExit.heightAnchor.constraint(equalToConstant: 40),
            buttonExit.widthAnchor.constraint(equalToConstant: 60),
            buttonExit.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
        ]
    }
    
    @objc private func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .right {
            self.tabBarController!.selectedIndex -= 1
        }
    }
    
    @objc private func exitAction() {
        
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set(false, forKey: "dataAvailability")
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: \(signOutError)")
        }
        
    }
    
    @objc private func didBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func didDeleteAccButtonTap() {
        
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
            _ = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(String( Auth.auth().currentUser!.uid)).removeValue()
            Auth.auth().currentUser?.delete(completion: { (error) in
                self.dismiss(animated: true, completion: nil)
            })
        }
        
    }
    
}
