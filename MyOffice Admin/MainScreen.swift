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
        
        timerLabel = UILabel()
        timerLabel.text = "00:00:00"
        timerLabel.font.withSize(18)
        timerLabel.textAlignment = .center
        timerLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timerLabel)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            title.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            title.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            
            avatarUser.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 50),
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
            
            timerLabel.topAnchor.constraint(equalTo: connectionButton.bottomAnchor, constant: 20),
            timerLabel.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor)
        ])
    }
    
    @objc private func timerUpdate() {
        
        /**
         Уверен, что этот код можно сократить, я писал в лоб, чтобы просто добиться формата "00:00:00"
         */
        // TODO: - Продумать логику
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
        // TODO: - Разобраться почему происходит автообновление
        if (sender.isSelected) {
            timer.invalidate()
            var f = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            print(Calendar.current.component(.month, from: f))
            
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
                    switch Calendar.current.component(.month, from: Date()) {
                    case 1:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) января": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 2:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) февраля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 3:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) марта": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 4:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) апреля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 5:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) мая": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 6:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июня": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 7:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 8:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) августа": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 9:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) сентября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 10:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) октября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 11:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) ноября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    case 12:
                        baseLeaving.updateChildValues(["\(Calendar.current.component(.day, from: Date())) декабря": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                        return
                    default:
                        print("Быть такого не может")
                    }

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
                    // TODO: - У новых сотрудников не появляется "working" и "coming"
                    let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("coming")
                    let baseWork = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("work")
                    baseWork.updateChildValues(["check": true])
                    base.observe(.value, with:  { (snapshot) in
                        guard let value = snapshot.value, snapshot.exists() else { return }
                        let dict: NSDictionary = value as! NSDictionary
                        print(dict)
                        for i in dict.allKeys {
                            switch Calendar.current.component(.month, from: Date()) {
                            case 1:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) января" {
                                    print(i)
                                    return
                                }
                            case 2:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) февраля" {
                                    print(i)
                                    return;
                                }
                            case 3:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) марта" {
                                    print(i)
                                    return
                                }
                            case 4:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) апреля" {
                                    print(i)
                                    return
                                }
                            case 5:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) мая" {
                                    print(i)
                                    return
                                }
                            case 6:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) июня" {
                                    print(i)
                                    return
                                }
                            case 7:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) июля" {
                                    print(i)
                                    return
                                }
                            case 8:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) августа" {
                                    print(i)
                                    return
                                }
                            case 9:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) сентября" {
                                    print(i)
                                    return
                                }
                            case 10:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) октября" {
                                    print(i)
                                    return
                                }
                            case 11:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) ноября" {
                                    print(i)
                                    return
                                }
                            case 12:
                                if i as? String == "\(Calendar.current.component(.day, from: Date())) декабря" {
                                    print(i)
                                    return
                                }
                            default:
                                print("Если ты это видишь, то ты изверг и испортил код")
                            }
                        }
                        switch Calendar.current.component(.month, from: Date()) {
                        case 1:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) января": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 2:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) февраля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 3:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) марта": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 4:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) апреля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 5:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) мая": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 6:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июня": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 7:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) июля": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 8:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) августа": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 9:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) сентября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 10:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) октября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 11:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) ноября": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        case 12:
                            base.updateChildValues(["\(Calendar.current.component(.day, from: Date())) декабря": "\(Calendar.current.component(.hour, from: Date())):\(Calendar.current.component(.minute, from: Date()))"])
                            return
                        default:
                            print("Быть такого не может")
                        }
                    })
                }
            })
        }
    }
    
}
