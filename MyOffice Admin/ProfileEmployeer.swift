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
        
        let labelHoursWeek = UILabel()
        labelHoursWeek.text = "за неделю"
        labelHoursWeek.font.withSize(14)
        labelHoursWeek.textAlignment = .center
        labelHoursWeek.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursWeek.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelHoursWeek)
        
        let labelQuantityHoursWeek = UILabel()
        labelQuantityHoursWeek.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursWeek.textAlignment = .center
        labelQuantityHoursWeek.text = "30 ч"
        labelQuantityHoursWeek.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelQuantityHoursWeek)
        
        let labelHoursMonth = UILabel()
        labelHoursMonth.text = "за месяц"
        labelHoursMonth.font.withSize(14)
        labelHoursMonth.textAlignment = .center
        labelHoursMonth.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursMonth.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelHoursMonth)
        
        let labelQuantityHoursMonth = UILabel()
        labelQuantityHoursMonth.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursMonth.textAlignment = .center
        labelQuantityHoursMonth.text = "160 ч"
        labelQuantityHoursMonth.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelQuantityHoursMonth)
        
        let labelAllOfHours = UILabel()
        labelAllOfHours.text = "за все время"
        labelAllOfHours.font.withSize(14)
        labelAllOfHours.textAlignment = .center
        labelAllOfHours.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelAllOfHours.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelAllOfHours)
        
        let labelQuantityAllOfHours = UILabel()
        labelQuantityAllOfHours.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityAllOfHours.textAlignment = .center
        labelQuantityAllOfHours.text = "10000 ч"
        labelQuantityAllOfHours.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelQuantityAllOfHours)
        
        let stackViewWeekLabel = UIStackView(arrangedSubviews: [labelQuantityHoursWeek, labelHoursWeek])
        stackViewWeekLabel.axis = .vertical
        stackViewWeekLabel.distribution = .fillEqually
        stackViewWeekLabel.alignment = .center
        stackViewWeekLabel.backgroundColor = .black
        stackViewWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewWeekLabel)
        
        let stackViewMonthLabel = UIStackView(arrangedSubviews: [labelQuantityHoursMonth, labelHoursMonth])
        stackViewMonthLabel.axis = .vertical
        stackViewMonthLabel.distribution = .fillEqually
        stackViewMonthLabel.alignment = .center
        stackViewMonthLabel.backgroundColor = .black
        stackViewMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewMonthLabel)
        
        let stackViewAllOfTimeLabel = UIStackView(arrangedSubviews: [labelQuantityAllOfHours, labelAllOfHours])
        stackViewAllOfTimeLabel.axis = .vertical
        stackViewAllOfTimeLabel.distribution = .fillEqually
        stackViewAllOfTimeLabel.alignment = .center
        stackViewAllOfTimeLabel.backgroundColor = .black
        stackViewAllOfTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackViewAllOfTimeLabel)
        
        let groupStackViewStatistic = UIStackView(arrangedSubviews: [stackViewWeekLabel, stackViewMonthLabel, stackViewAllOfTimeLabel])
        groupStackViewStatistic.axis = .horizontal
        groupStackViewStatistic.distribution = .fillEqually
        groupStackViewStatistic.alignment = .center
        groupStackViewStatistic.spacing = 10
        groupStackViewStatistic.backgroundColor = .black
        groupStackViewStatistic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(groupStackViewStatistic)
        
        let labelBirthday = UILabel()
        labelBirthday.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelBirthday.font = UIFont(name: "Roboto-Regular", size: 6)
        labelBirthday.numberOfLines = 0
        labelBirthday.lineBreakMode = .byWordWrapping
        labelBirthday.text = "Дата рождения:"
        labelBirthday.textAlignment = .left
        labelBirthday.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelBirthday)
        
        let labelBirthdayDate = UILabel()
        labelBirthdayDate.text = "00.00.0000"
        labelBirthdayDate.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelBirthdayDate.font = UIFont(name: "Roboto-Regular", size: 8)
        labelBirthdayDate.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelBirthdayDate)
        
        let labelPhone = UILabel()
        labelPhone.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelPhone.font = UIFont(name: "Roboto-Regular", size: 6)
        labelPhone.numberOfLines = 0
        labelPhone.lineBreakMode = .byWordWrapping
        labelPhone.text = "Номер телефона:"
        labelPhone.textAlignment = .left
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelPhone)
        
        let labelPhoneNumber = UILabel()
        labelPhoneNumber.text = "+7(123)456-78-90"
        labelPhoneNumber.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelPhoneNumber.font = UIFont(name: "Roboto-Regular", size: 8)
        labelPhoneNumber.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelPhoneNumber)
        
        let labelPass = UILabel()
        labelPass.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelPass.font.withSize(6)
        labelPass.numberOfLines = 0
        labelPass.lineBreakMode = .byWordWrapping
        labelPass.text = "Серия и номер пасспорта:"
        labelPass.textAlignment = .left
        labelPass.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelPass)
        
        let labelNumberOfPass = UILabel()
        labelNumberOfPass.text = "60 14 123456"
        labelNumberOfPass.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelNumberOfPass.font.withSize(8)
        labelNumberOfPass.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelNumberOfPass)
        
        let labelName = UILabel()
        labelName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        labelName.font.withSize(6)
        labelName.numberOfLines = 0
        labelName.lineBreakMode = .byWordWrapping
        labelName.text = "Ф.И.О:"
        labelName.textAlignment = .left
        labelName.translatesAutoresizingMaskIntoConstraints = false
//        let stackViewName
        
        let labelFullName = UILabel()
        labelFullName.text = "Когут Никита Алексеевич"
        labelFullName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelFullName.numberOfLines = 0
        labelFullName.font.withSize(8)
        labelFullName.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(labelNumberOfPass)
        
        let buttonExit = UIButton()
        buttonExit.setTitle("Выход", for: .normal)
        buttonExit.setTitleColor(.red, for: .normal)
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
            
            groupStackViewStatistic.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            groupStackViewStatistic.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            groupStackViewStatistic.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            groupStackViewStatistic.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            
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
            groupStackViewInfo.topAnchor.constraint(equalTo: groupStackViewStatistic.bottomAnchor, constant: 40),
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
