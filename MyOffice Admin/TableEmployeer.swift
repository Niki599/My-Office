//
//  TableEmployeer.swift
//  IOS
//
//  Created by Андрей Гаврилов on 06/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class TableEmployeer: UIViewController {
    
    // MARK: - Public Properties
    
    /**
     Модель всех сотрудников
     */
    var data: Company!
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser(), days: DaysOfWeek())
    
    // MARK: - Private Properties
    
    private let identifire = "MyCell"

    private var titleLabel: UILabel!
    private var tableEmployeer: UITableView!
    private var backgroundView: UIView!
    private var updateButton: UIButton!
    private var labelQuantityHoursWeek: UILabel!
    private var labelQuantityHoursMonth: UILabel!
    private var labelQuantityAllOfHours: UILabel!

    private var constraints: [NSLayoutConstraint]!
    private var stackViewHeader: UIStackView!

    private lazy var labelHeaderDate: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Дата"
        label.backgroundColor = .white
        return label
    }()

    private lazy var labelHeaderComming: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Приход"
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var labelHeaderLeaving: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Уход"
        label.backgroundColor = .white
        return label
    }()
    
    private lazy var labelHeaderTimeOfWorking: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Всего"
        label.backgroundColor = .white
        return label
    }()
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        titleLabel = UILabel()
        titleLabel.text = "Мои данные"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        tableEmployeer = UITableView()
        tableEmployeer.translatesAutoresizingMaskIntoConstraints = false
        tableEmployeer.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        tableEmployeer.delegate = self
        tableEmployeer.dataSource = self
        tableEmployeer.separatorStyle = .none
        view.addSubview(tableEmployeer)
        
        updateButton = UIButton()
        updateButton.addTarget(self, action: #selector(didUpdateButtonTap), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.setImage(UIImage(imageLiteralResourceName: "update.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        view.addSubview(updateButton)
        
        let profileButton = UIButton()
//        profileButton.addTarget(self, action: #selector(requestData), for: .touchUpInside)
        profileButton.backgroundColor = .red
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileButton)
        
        let labelHoursWeek = UILabel()
        labelHoursWeek.text = "за неделю"
        labelHoursWeek.font.withSize(14)
        labelHoursWeek.textAlignment = .center
        labelHoursWeek.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursWeek.translatesAutoresizingMaskIntoConstraints = false
        
        labelQuantityHoursWeek = UILabel()
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
        
        labelQuantityHoursMonth = UILabel()
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
        
        labelQuantityAllOfHours = UILabel()
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
        
        constraints = [
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            updateButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            updateButton.widthAnchor.constraint(equalToConstant: 40),
            updateButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -5),
            
            profileButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            profileButton.leftAnchor.constraint(equalTo: view.safeArea.leftAnchor, constant: 25),
            profileButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -25),
            profileButton.heightAnchor.constraint(equalToConstant: 62),
            
            groupStackViewStatistic.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            groupStackViewStatistic.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 44),
            groupStackViewStatistic.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            groupStackViewStatistic.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            
            tableEmployeer.topAnchor.constraint(equalTo: groupStackViewStatistic.bottomAnchor, constant: 25),
            tableEmployeer.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            tableEmployeer.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            tableEmployeer.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor),
        ]
        
        var date1 = Date()
        var date2 = Date(timeIntervalSinceNow: 72000)
        let dateDiff = Calendar.current.dateComponents([.minute], from: date2, to: date1).minute
        let st = "\(dateDiff! / 60)" + ".\(dateDiff! % 60)"
        
        let hour = Calendar.current.component(.hour, from: Date())
        let minute = Calendar.current.component(.month, from: Date())
        print(minute)
        var timeIsNow = "\(hour) + \(minute)"
        
    }
    
    @objc private func didUpdateButtonTap() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
            if user != nil {
                let hams = Auth.auth().currentUser?.uid
                let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!)
                self.data.users.removeAll()
                // TODO: Вынести в отдельную функцию
                base.observe(.value, with:  { (snapshot) in
                    guard let value = snapshot.value, snapshot.exists() else { return }
                    let dict: NSDictionary = value as! NSDictionary
                    for (uid, categories) in dict as! NSDictionary {
                        for (category, fields) in categories as! NSDictionary {
                            for (nameOfField, valueOfField) in fields as! NSDictionary {
                                if nameOfField as? String == "admin" {
                                    if hams == uid as? String {
                                        UserDefaults.standard.set(valueOfField, forKey: "admin")
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
                                    if hams == uid as? String {
                                        self.labelQuantityHoursMonth.text = String(valueOfField as! Int)
                                    }
                                    continue
                                }
                                if nameOfField as? String == "totalHours" {
                                    self.oneOfUsers.work.totalHours = valueOfField as? Int
                                    if hams == uid as? String {
                                        self.labelQuantityAllOfHours.text = String(valueOfField as! Int)
                                    }
                                    continue
                                }
                                if nameOfField as? String == "weekHours" {
                                    self.oneOfUsers.work.weekHours = valueOfField as? Int
                                    if hams == uid as? String {
                                        self.labelQuantityHoursWeek.text = String(valueOfField as! Int)
                                    }
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
                })
                activityIndicator.stopAnimating() // TODO: - Вовремя
            }
            else {
                print("Error")
            }
        }
        // TODO: - Только при двойном нажатии он обновит таблицу
        self.tableEmployeer.reloadData()
        
    }
        
    private func info() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Info")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TableEmployeer : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        stackViewHeader = UIStackView(arrangedSubviews: [labelHeaderDate, labelHeaderComming, labelHeaderLeaving, labelHeaderTimeOfWorking])
        stackViewHeader.axis = .horizontal
        stackViewHeader.alignment = .center
        stackViewHeader.distribution = .fillEqually
        
        let constraintsOfLabel: [NSLayoutConstraint] = [
            labelHeaderDate.topAnchor.constraint(equalTo: stackViewHeader.topAnchor),
            labelHeaderComming.topAnchor.constraint(equalTo: stackViewHeader.topAnchor),
            labelHeaderLeaving.topAnchor.constraint(equalTo: stackViewHeader.topAnchor),
            labelHeaderTimeOfWorking.topAnchor.constraint(equalTo: stackViewHeader.topAnchor)
        ]
        NSLayoutConstraint.deactivate(constraintsOfLabel)
        NSLayoutConstraint.activate(constraintsOfLabel)
        
        return stackViewHeader
    }
}

extension TableEmployeer : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .default, reuseIdentifier: "MyCell", data: data, indexPath: indexPath, accessoryType: .none)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    /**
     Нажатие на (i)
     */
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("hui")
    }
    
}
