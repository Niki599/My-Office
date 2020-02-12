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
    
    // MARK: - Public Properties
    
    var data: Company!
    
    // MARK: - Private Properties
    
    private var connectionButton: UIButton!
    private var infoConnection: UILabel!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        
        let logoImage = UIImage(imageLiteralResourceName: "employee.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        let avatarUser = UIImageView(image: logoImage)
        avatarUser.layer.cornerRadius = 0.5
        avatarUser.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarUser)
        
        connectionButton = UIButton(type: .custom)
        connectionButton.layer.borderWidth = 1
        connectionButton.layer.cornerRadius = 5
        connectionButton.setTitle("Подключиться", for: .normal)
        connectionButton.setTitle("Отключиться", for: .selected)
        connectionButton.setTitleColor(.white, for: .normal)
        connectionButton.setTitleColor(.lightGray, for: .highlighted)
        connectionButton.backgroundColor = .black
        connectionButton.translatesAutoresizingMaskIntoConstraints = false
        connectionButton.clipsToBounds = true
        connectionButton.addTarget(nil, action: #selector(didTapJoinButton(_:)), for: .touchUpInside)
        connectionButton.isHidden = false
        connectionButton.isUserInteractionEnabled = true
        view.addSubview(connectionButton)
        
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Главная"
        title.textAlignment = .center
        title.textColor = .black
        view.addSubview(title)
        
        infoConnection = UILabel()
        infoConnection.translatesAutoresizingMaskIntoConstraints = false
        infoConnection.text = "Отсутствует"
        infoConnection.textAlignment = .center
        infoConnection.textColor = .red
        view.addSubview(infoConnection)
        
        let labelHoursWeek = UILabel()
        labelHoursWeek.text = "за неделю"
        labelHoursWeek.font.withSize(14)
        labelHoursWeek.textAlignment = .center
        labelHoursWeek.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursWeek.translatesAutoresizingMaskIntoConstraints = false
        
        let labelQuantityHoursWeek = UILabel()
        labelQuantityHoursWeek.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursWeek.textAlignment = .center
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login")! {
                labelQuantityHoursWeek.text = String(user.work.weekHours!)
            }
        }
        labelQuantityHoursWeek.translatesAutoresizingMaskIntoConstraints = false
        
        let labelHoursMonth = UILabel()
        labelHoursMonth.text = "за месяц"
        labelHoursMonth.font.withSize(14)
        labelHoursMonth.textAlignment = .center
        labelHoursMonth.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursMonth.translatesAutoresizingMaskIntoConstraints = false
        
        let labelQuantityHoursMonth = UILabel()
        labelQuantityHoursMonth.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursMonth.textAlignment = .center
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login")! {
                labelQuantityHoursMonth.text = String(user.work.monthHours!)
            }
        }
        labelQuantityHoursMonth.translatesAutoresizingMaskIntoConstraints = false
        
        let labelAllOfHours = UILabel()
        labelAllOfHours.text = "за все время"
        labelAllOfHours.font.withSize(14)
        labelAllOfHours.textAlignment = .center
        labelAllOfHours.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelAllOfHours.translatesAutoresizingMaskIntoConstraints = false
        
        let labelQuantityAllOfHours = UILabel()
        labelQuantityAllOfHours.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityAllOfHours.textAlignment = .center
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login")! {
                labelQuantityAllOfHours.text = String(user.work.totalHours!)
            }
        }
        labelQuantityAllOfHours.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewWeekLabel = UIStackView(arrangedSubviews: [labelQuantityHoursWeek, labelHoursWeek])
        stackViewWeekLabel.axis = .vertical
        stackViewWeekLabel.distribution = .fillEqually
        stackViewWeekLabel.alignment = .center
        stackViewWeekLabel.backgroundColor = .black
        stackViewWeekLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewMonthLabel = UIStackView(arrangedSubviews: [labelQuantityHoursMonth, labelHoursMonth])
        stackViewMonthLabel.axis = .vertical
        stackViewMonthLabel.distribution = .fillEqually
        stackViewMonthLabel.alignment = .center
        stackViewMonthLabel.backgroundColor = .black
        stackViewMonthLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewAllOfTimeLabel = UIStackView(arrangedSubviews: [labelQuantityAllOfHours, labelAllOfHours])
        stackViewAllOfTimeLabel.axis = .vertical
        stackViewAllOfTimeLabel.distribution = .fillEqually
        stackViewAllOfTimeLabel.alignment = .center
        stackViewAllOfTimeLabel.backgroundColor = .black
        stackViewAllOfTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            
            title.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            
            avatarUser.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 80),
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
        ])
    }
        
    @objc private func didTapJoinButton(_ sender: UIButton) {
        if (sender.isSelected){
            infoConnection.text = "Отсутствует"
            infoConnection.textColor = .red
            sender.isSelected = false
            sender.setTitle("Подключиться", for: .focused)
            //        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!, completion: { (user, error) in
            //            if ((user) != nil) {
            //                let hams = Auth.auth().currentUser?.uid
            //                let base = Database.database().reference().child("users2").child(hams!)
            //                base.updateChildValues(["check":false])
            //            }})

            return
        }
        if !(sender.isSelected) {
            infoConnection.text = "На работе"
            infoConnection.textColor = .green
            sender.isSelected = true
            sender.setTitle("Отключиться", for: .focused)

            //        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!, completion: { (user, error) in
            //            if ((user) != nil) {
            //                let hams = Auth.auth().currentUser?.uid
            //                let base = Database.database().reference().child("users2").child(hams!)
            //                base.updateChildValues(["check":true])
            //            }})

        }
    }
    
}
