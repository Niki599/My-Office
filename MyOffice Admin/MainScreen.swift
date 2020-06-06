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
    var myId: Int = 0
    
    // MARK: - Private Properties
    
    private var connectionButton: UIButton!
    private var infoConnection: UILabel!
    private var timerLabel: UILabel!
    private var timer: Timer!
    private var minutesIsJob: Double!
    private var wifi: String!
    private var alertView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard UserDefaults.standard.string(forKey: "login") != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        for i in 0...data.users.count - 1 {
            if data.users[i].info.email == UserDefaults.standard.string(forKey: "login") {
                if (data.users[i].work.check == true) {
                    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: NSDate(), repeats: true)
                    // TODO: - Продумать логику
                    infoConnection.text = "На работе"
                    infoConnection.textColor = .green
                    connectionButton.isSelected = true
                    connectionButton.setTitle("Отключиться", for: .focused)
                }
            }
        }

        super.viewWillAppear(animated)
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
                
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        let avatarUser = UIImageView(image: UIImage(named: "employee.png"))
        avatarUser.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarUser)
        
        connectionButton = UIButton(type: .custom)
        connectionButton.layer.borderWidth = 1
        connectionButton.layer.cornerRadius = 5
        connectionButton.setTitle("Подключиться", for: .normal)
        connectionButton.setTitle("Отключиться", for: .selected)
        connectionButton.setTitleColor(.yellow, for: .normal)
        connectionButton.setTitleColor(.lightGray, for: .highlighted)
        connectionButton.backgroundColor = .blue
        connectionButton.translatesAutoresizingMaskIntoConstraints = false
        connectionButton.clipsToBounds = true
        connectionButton.addTarget(nil, action: #selector(didTapJoinButton(_:)), for: .touchUpInside)
        connectionButton.isHidden = false
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
        labelQuantityAllOfHours.translatesAutoresizingMaskIntoConstraints = false
        
        for user in data.users {
            if user.info.email == UserDefaults.standard.string(forKey: "login")! {
                labelQuantityHoursWeek.text = "\(user.work.weekHours!)"
                labelQuantityHoursMonth.text = "\(user.work.monthHours!)"
                labelQuantityAllOfHours.text = "\(user.work.totalHours!)"
                wifi = user.work.wifi
            }
        }
        
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
        
        timerLabel = UILabel()
        timerLabel.text = "00:00:00"
        timerLabel.font.withSize(18)
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerLabel)
        
        alertView = UIView()
        alertView.alpha = 0
        alertView.backgroundColor = .white
        alertView.layer.shadowColor = UIColor.black.cgColor
        alertView.layer.shadowOpacity = 0.2
        alertView.layer.shadowOffset = CGSize(width: 0, height: 4)
        alertView.layer.shadowRadius = 5
        alertView.layer.cornerRadius = 8
        alertView.layer.masksToBounds = false
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertView)
        
        let alertImage = UIImageView(image: UIImage(named: "mdi_error.png"))
        alertImage.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(alertImage)

        let alertLabel = UILabel()
        alertLabel.text = "Вы не подключились к Wi-Fi сети"
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(alertLabel)

        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            title.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            
            avatarUser.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: UIScreen.main.bounds.height / 6.0),
            avatarUser.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
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
            
            timerLabel.topAnchor.constraint(equalTo: connectionButton.bottomAnchor, constant: 20),
            timerLabel.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            
            alertView.heightAnchor.constraint(equalTo: connectionButton.heightAnchor),
            alertView.widthAnchor.constraint(equalTo: connectionButton.widthAnchor, constant: 10),
            alertView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            
            alertImage.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            alertImage.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 5),
            
            alertLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            alertLabel.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
        ])
    }
    
    @objc private func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.tabBarController!.selectedIndex += 1
        }
        if sender.direction == .right {
            self.tabBarController!.selectedIndex -= 1
        }
    }

    @objc private func timerUpdate() {
        
        /**
         Уверен, что этот код можно сократить, я писал в лоб, чтобы просто добиться формата "00:00:00"
         */
//        guard self.timer != nil else { return }
        let elapsed = -(self.timer.userInfo as! NSDate).timeIntervalSinceNow
        minutesIsJob = floor(elapsed / 60)
        
        if elapsed < 10 {
            timerLabel.text = String(format: "00:00:0%.0f", elapsed)
            return
        }
        if elapsed >= 10 && elapsed < 60 {
            timerLabel.text = String(format: "00:00:%.0f", elapsed)
            return
        }
        if elapsed >= 60 && elapsed < 600 {
            if elapsed.truncatingRemainder(dividingBy: 60) < 10 {
                timerLabel.text = String(format: "00:0%.0f:0%.0f", floor(elapsed / 60), elapsed.truncatingRemainder(dividingBy: 60))
            } else {
                timerLabel.text = String(format: "00:0%.0f:%.0f", floor(elapsed / 60), elapsed.truncatingRemainder(dividingBy: 60))
            }
            return
        }
        if elapsed >= 600 && elapsed < 3600 {
            if elapsed.truncatingRemainder(dividingBy: 60) < 10 {
                timerLabel.text = String(format: "00:%.0f:0%.0f", floor(elapsed / 60), elapsed.truncatingRemainder(dividingBy: 60))
            } else {
                timerLabel.text = String(format: "00:%.0f:%.0f", floor(elapsed / 60), elapsed.truncatingRemainder(dividingBy: 60))
            }
            return
        }
        if elapsed >= 3600 && elapsed < 36000 {
            // TODO: - Продумать логику
            if elapsed.truncatingRemainder(dividingBy: 60) < 10 {
                if floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60) < 10 {
                    timerLabel.text = String(format: "0%.0f:0%.0f:0%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                } else {
                timerLabel.text = String(format: "0%.0f:%.0f:0%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                }
            } else {
                if floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60) < 10 {
                    timerLabel.text = String(format: "0%.0f:0%.0f:%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                } else {
                    timerLabel.text = String(format: "0%.0f:0%.0f:%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                }
            }
            return
        }
        if elapsed >= 36000 {
            if elapsed.truncatingRemainder(dividingBy: 60) < 10 {
                if floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60) < 10 {
                    if floor(elapsed / 3600) < 10 {
                        timerLabel.text = String(format: "0%.0f:0%.0f:0%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                    } else {
                        timerLabel.text = String(format: "%.0f:0%.0f:0%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                    }
                } else {
                    timerLabel.text = String(format: "%.0f:%.0f:0%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
                }
            } else {
                timerLabel.text = String(format: "%.0f:%.0f:%.0f", floor(elapsed / 3600), floor(elapsed.truncatingRemainder(dividingBy: 3600) / 60), floor(elapsed.truncatingRemainder(dividingBy: 60)))
            }
            return
        }
    }
        
    @objc private func didTapJoinButton(_ sender: UIButton) {
        if getIp() == wifi {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
        if (sender.isSelected) {
            timer.invalidate()
            infoConnection.text = "Отсутствует"
            infoConnection.textColor = .red
            sender.isSelected = false
            sender.setTitle("Подключиться", for: .focused)
            for i in 0...data.users.count - 1 {
                if data.users[i].info.email == UserDefaults.standard.string(forKey: "login") {
                    data.users[i].work.check = false
                    myId = i
                    guard minutesIsJob != nil else {
                        return
                    }
                    let roundedMinutes = minutesIsJob / 60
                    data.users[i].work.weekHours! += Double(Int(minutesIsJob) / 60) + roundedMinutes.rounded(toPlaces: 2)
                    data.users[i].work.monthHours! += Double(Int(minutesIsJob) / 60) + roundedMinutes.rounded(toPlaces: 2)
                    data.users[i].work.totalHours! += Double(Int(minutesIsJob) / 60) + roundedMinutes.rounded(toPlaces: 2)
                }
            }
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!, completion: { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    let baseLeaving = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("leaving")
                    let baseWork = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work")
                    baseWork.updateChildValues(["check": false, "weekHours": self.data.users[self.myId].work.weekHours!, "monthHours": self.data.users[self.myId].work.monthHours!, "totalHours": self.data.users[self.myId].work.totalHours!])
                    activityIndicator.stopAnimating()
                    switch Calendar.current.component(.month, from: Date()) {
                    case 1:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) january": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 2:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) february": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 3:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) march": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 4:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) april": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 5:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) may": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 6:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) june": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 7:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) july": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 8:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) augustа": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 9:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) september": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 10:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) october": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 11:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) november": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 12:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) december": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    default:
                        print("Быть такого не может")
                    }
                } else {
                    activityIndicator.stopAnimating()
                }
            })
            return
        } else {
            // TODO: - Продумать логику
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerUpdate), userInfo: NSDate(), repeats: true)
            infoConnection.text = "На работе"
            infoConnection.textColor = .green
            sender.isSelected = true
            sender.setTitle("Отключиться", for: .focused)
            for i in 0...data.users.count - 1 {
                if data.users[i].info.email == UserDefaults.standard.string(forKey: "login") {
                    data.users[i].work.check = true
                }
            }
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!, completion: { (user, error) in
                if user != nil {
                    let hams = Auth.auth().currentUser?.uid
                    let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("coming")
                    let baseWork = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work")
                    baseWork.updateChildValues(["check": true])
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        activityIndicator.stopAnimating()
                        for i in dict.allKeys {
                            switch Calendar.current.component(.month, from: Date()) {
                            case 1:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) january" {
                                    print(i)
                                    return
                                }
                            case 2:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) february" {
                                    print(i)
                                    return;
                                }
                            case 3:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) march" {
                                    print(i)
                                    return
                                }
                            case 4:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) april" {
                                    print(i)
                                    return
                                }
                            case 5:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) may" {
                                    print(i)
                                    return
                                }
                            case 6:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) june" {
                                    print(i)
                                    return
                                }
                            case 7:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) july" {
                                    print(i)
                                    return
                                }
                            case 8:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) augustа" {
                                    print(i)
                                    return
                                }
                            case 9:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) september" {
                                    print(i)
                                    return
                                }
                            case 10:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) october" {
                                    print(i)
                                    return
                                }
                            case 11:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) november" {
                                    print(i)
                                    return
                                }
                            case 12:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) december" {
                                    print(i)
                                    return
                                }
                            default:
                                print("Если ты это видишь, то ты изверг и испортил код")
                            }
                        }
                        switch Calendar.current.component(.month, from: Date()) {
                        case 1:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) january": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 2:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) february": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 3:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) march": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 4:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) april": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 5:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) may": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 6:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) june": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 7:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) july": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 8:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) augustа": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 9:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) september": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 10:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) october": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 11:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) november": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        case 12:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) december": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        default:
                            print("Быть такого не может")
                        }
                    })
                } else {
                    activityIndicator.stopAnimating()
                }
            })
        }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.alertView.alpha = 1
                self.alertView.center.y += 120
                self.connectionButton.isUserInteractionEnabled = false
            }, completion: { (bool) in
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
                    self.alertView.alpha = 0
                    self.alertView.center.y -= 120
                }, completion: { (bool) in
                    self.connectionButton.isUserInteractionEnabled = true
                })
            })
        }
    }
    
    //Функция по нахождению ip-адреса
    private func getIp() -> String {
        let url = URL(string: "https://api.ipify.org")
        do {
            if let url = url {
                let ipAddress = try String(contentsOf: url)
                return ipAddress
            }
        } catch let error {
            print(error)
        }
        return ""
    }
    
}
