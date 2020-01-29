//
//  MainScreen.swift
//  MyOffice Admin
//
//  Created by Nikita on 24/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase

class MainScreen: UIViewController {
    
    var connectionButton: UIButton!
    var disconnectButton: UIButton!
    var infoConnection: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    func setupViews() {
        
        let logoImage = UIImage(imageLiteralResourceName: "employee.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        let avatarUser = UIImageView(image: logoImage)
        avatarUser.layer.cornerRadius = 0.5
        avatarUser.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarUser)
        
        connectionButton = UIButton()
        connectionButton.layer.borderWidth = 1
        connectionButton.layer.cornerRadius = 5
        connectionButton.setTitle("Подключиться", for: .normal)
        connectionButton.setTitleColor(.white, for: .normal)
        connectionButton.backgroundColor = .black
        connectionButton.translatesAutoresizingMaskIntoConstraints = false
        connectionButton.clipsToBounds = true
        connectionButton.addTarget(nil, action: #selector(joinToWork), for: .touchUpInside)
        connectionButton.isHidden = false
        connectionButton.isUserInteractionEnabled = true
        view.addSubview(connectionButton)
        
        disconnectButton = UIButton()
        disconnectButton.layer.borderWidth = 1
        disconnectButton.layer.cornerRadius = 5
        disconnectButton.setTitle("Отключиться", for: .normal)
        disconnectButton.setTitleColor(.white, for: .normal)
        disconnectButton.backgroundColor = .black
        disconnectButton.translatesAutoresizingMaskIntoConstraints = false
        disconnectButton.clipsToBounds = true
        disconnectButton.addTarget(nil, action: #selector(exitOfWork), for: .touchUpInside)
        disconnectButton.isHidden = true
        disconnectButton.isUserInteractionEnabled = false
        view.addSubview(disconnectButton)
        
        let navLabel = UILabel()
        navLabel.translatesAutoresizingMaskIntoConstraints = false
        navLabel.text = "Главная"
        navLabel.textAlignment = .center
        navLabel.textColor = .black
        view.addSubview(navLabel)
        
        infoConnection = UILabel()
        infoConnection.translatesAutoresizingMaskIntoConstraints = false
//        infoConnection.text = "Отсутствует"
        infoConnection.textAlignment = .center
        infoConnection.textColor = .red
        view.addSubview(infoConnection)
        
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
//        view.addSubview(stackViewWeekLabel)
        
        let stackViewMonthLabel = UIStackView(arrangedSubviews: [labelQuantityHoursMonth, labelHoursMonth])
        stackViewMonthLabel.axis = .vertical
        stackViewMonthLabel.distribution = .fillEqually
        stackViewMonthLabel.alignment = .center
        stackViewMonthLabel.backgroundColor = .black
        stackViewMonthLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackViewMonthLabel)
        
        let stackViewAllOfTimeLabel = UIStackView(arrangedSubviews: [labelQuantityAllOfHours, labelAllOfHours])
        stackViewAllOfTimeLabel.axis = .vertical
        stackViewAllOfTimeLabel.distribution = .fillEqually
        stackViewAllOfTimeLabel.alignment = .center
        stackViewAllOfTimeLabel.backgroundColor = .black
        stackViewAllOfTimeLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(stackViewAllOfTimeLabel)
        
        let groupStackViewStatistic = UIStackView(arrangedSubviews: [stackViewWeekLabel, stackViewMonthLabel, stackViewAllOfTimeLabel])
        groupStackViewStatistic.axis = .horizontal
        groupStackViewStatistic.distribution = .fillEqually
        groupStackViewStatistic.alignment = .center
        groupStackViewStatistic.spacing = 10
        groupStackViewStatistic.backgroundColor = .black
        groupStackViewStatistic.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(groupStackViewStatistic)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            navLabel.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            navLabel.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 5),
            
            avatarUser.topAnchor.constraint(equalTo: navLabel.bottomAnchor,constant: 80),
            avatarUser.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            avatarUser.heightAnchor.constraint(equalToConstant: 120),
            avatarUser.widthAnchor.constraint(equalTo: avatarUser.heightAnchor),
            
            infoConnection.topAnchor.constraint(equalTo: avatarUser.bottomAnchor, constant: 14),
            infoConnection.leadingAnchor.constraint(equalTo: avatarUser.leadingAnchor,constant: -10),
            infoConnection.trailingAnchor.constraint(equalTo: avatarUser.trailingAnchor,constant: 10),
            infoConnection.heightAnchor.constraint(equalToConstant: 40),
            
            groupStackViewStatistic.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            groupStackViewStatistic.topAnchor.constraint(equalTo: infoConnection.bottomAnchor, constant: 40),
            groupStackViewStatistic.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 20),
            groupStackViewStatistic.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -20),
            
            connectionButton.topAnchor.constraint(equalTo: groupStackViewStatistic.bottomAnchor, constant: 60),
            connectionButton.leadingAnchor.constraint(equalTo: groupStackViewStatistic.leadingAnchor,constant: 10),
            connectionButton.trailingAnchor.constraint(equalTo: groupStackViewStatistic.trailingAnchor,constant: -10),
            connectionButton.heightAnchor.constraint(equalToConstant: 40),
            
            disconnectButton.topAnchor.constraint(equalTo: groupStackViewStatistic.bottomAnchor, constant: 60),
            disconnectButton.leadingAnchor.constraint(equalTo: groupStackViewStatistic.leadingAnchor,constant: 10),
            disconnectButton.trailingAnchor.constraint(equalTo: groupStackViewStatistic.trailingAnchor,constant: -10),
            disconnectButton.heightAnchor.constraint(equalToConstant: 40),
            
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.viewDidLayoutSubviews()
    }
    
    @objc func joinToWork() {
//        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!, completion: { (user, error) in
//            if ((user) != nil) {
//                let hams = Auth.auth().currentUser?.uid
//                let base = Database.database().reference().child("users2").child(hams!)
//                base.updateChildValues(["check":true])
//            }})
        infoConnection.text = "На работе"
        infoConnection.textColor = .green
        connectionButton.isHidden = true
        connectionButton.isUserInteractionEnabled = false
        disconnectButton.isHidden = false
        disconnectButton.isUserInteractionEnabled = true
    }
    
    @objc func exitOfWork() {
//        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!, completion: { (user, error) in
//            if ((user) != nil) {
//                let hams = Auth.auth().currentUser?.uid
//                let base = Database.database().reference().child("users").child(hams!)
//                base.updateChildValues(["check":false])
//            }})
        infoConnection.text = "Отсутствует"
        infoConnection.textColor = .red
        connectionButton.isHidden = false
        connectionButton.isUserInteractionEnabled = true
        disconnectButton.isHidden = true
        disconnectButton.isUserInteractionEnabled = false
    }
    
}
