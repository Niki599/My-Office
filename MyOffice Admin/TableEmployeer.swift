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
    
    var check = [Int]()
    var email = [String]()
    var name = [String]()
    var phone = [String]()
    var surname = [String]()
    var data = ["", "", "", "", ""]
    let identifire = "MyCell"
    var data1 = Company.shared
    
    var titleTable: UILabel!
    var tableEmployeer: UITableView!
    var backgroundView: UIView!
    var updateButton: UIButton!
    
    var quantityEmployeers: Int!
    
    var constraints: [NSLayoutConstraint]!
    
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
    
    var stackViewHeader: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    func setupView() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        titleTable = UILabel()
        titleTable.text = "Мои данные"
        titleTable.translatesAutoresizingMaskIntoConstraints = false
        titleTable.textAlignment = .center
        view.addSubview(titleTable)
        
        tableEmployeer = UITableView()
        tableEmployeer.translatesAutoresizingMaskIntoConstraints = false
        tableEmployeer.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        tableEmployeer.delegate = self
        tableEmployeer.dataSource = self
        tableEmployeer.separatorStyle = .none
//        tableEmployeer.layer.borderWidth = 1.0
        view.addSubview(tableEmployeer)
        
        updateButton = UIButton()
        updateButton.addTarget(self, action: #selector(requestData), for: .touchUpInside)
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
        
        let labelQuantityHoursWeek = UILabel()
        labelQuantityHoursWeek.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursWeek.textAlignment = .center
//        labelQuantityHoursWeek.text = String(data1.users[0].work.weekHours!)
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
        labelQuantityHoursMonth.text = "160 ч"//Берем с базы
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
        labelQuantityAllOfHours.text = "10000 ч"//Берем с базы
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
            
            titleTable.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            titleTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            updateButton.centerYAnchor.constraint(equalTo: titleTable.centerYAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            updateButton.widthAnchor.constraint(equalToConstant: 40),
            updateButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -5),
            
            profileButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: titleTable.bottomAnchor, constant: 30),
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
        let minute = Calendar.current.component(.minute, from: Date())
        var timeIsNow = "\(hour) + \(minute)"
        
    }
    
    @objc func requestData() {
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
            for i in 0...self.data.count-1 {
                self.data[i] = ""
            }
            self.name.removeAll()
            self.surname.removeAll()
            self.check.removeAll()
            self.quantityEmployeers = 0
            let base = Database.database().reference().child("users")
            print(base)
            base.observe(.value, with:  { (snapshot) in
                guard let value = snapshot.value, snapshot.exists() else { return }
                let dict: NSDictionary = value as! NSDictionary
                for (_, _) in dict {
                    self.quantityEmployeers += 1
                }
                for (_, uidEmployeerInfo) in dict {
                    for (_, categ) in uidEmployeerInfo as! NSDictionary {
                        for (fieldName, valueOfField) in categ as! NSDictionary {
                            if (fieldName as? String == "name") {
                                self.name.append(valueOfField as! String)
                                //                                            print(valueOfField)
                            }
                            if (fieldName as? String == "surname") {
                                self.surname.append(valueOfField as! String)
                                //                                            print(valueOfField)
                            }
                            if (fieldName as? String == "check") {
                                self.check.append(valueOfField as! Int)
                                //                                            print(valueOfField)
                            }
                        }
                    }
                }
                for i in 0...self.quantityEmployeers-1 {
                    self.data[i] = self.name[i] + " " + self.surname[i] + " "
                    if  self.check[i] == 0 {
                        self.data[i] += "Нет на месте"
                    }
                    else {
                        self.data[i] += "На рабочем месте"
                    }
                    self.tableEmployeer.reloadData()
                }
            })
        }
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    func info() {
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
        stackViewHeader.backgroundColor = .black
        
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .default, reuseIdentifier: "MyCell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [0, 0]:
            print(indexPath)
        case [0, 1]:
            print(indexPath)
        default:
            print("hui")
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("hui")
    }
    
}
