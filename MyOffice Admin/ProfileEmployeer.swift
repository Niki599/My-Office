//
//  ProfileEmployeer.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 21/01/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class ProfileEmployeer: UIViewController {
    
//    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        super.viewWillAppear(animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        self.navigationController?.setNavigationBarHidden(false, animated: animated)
//        super.viewWillDisappear(animated)
//    }
    
    var constraints: [NSLayoutConstraint]!
    
    var data: Company!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupView() {
        view.backgroundColor = .white
        let title = UILabel()
        title.text = "Информация о сотруднике"
        title.font = UIFont(name: "Roboto-Regular", size: 14)
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(title)
        
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
        labelFullName.text = "Когут Никита Алексеевич"//Берем с базы
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
        labelBirthdayDate.text = "00.00.0000"//Берем с базы
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
        labelPhoneNumber.text = "+7(123)456-78-90"//Берем с базы
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
        labelNumberOfPass.text = "60 14 123456"//Берем с базы
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
            title.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 60),
                        
            //            labelBirthday.leadingAnchor.constraint(equalTo: stackViewBirthday.leadingAnchor),
            //            labelBirthdayDate.trailingAnchor.constraint(equalTo: stackViewBirthday.trailingAnchor),
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
    
    @objc func exitAction() {
        self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.set(false, forKey: "dataAvailability")
    }
    
}
