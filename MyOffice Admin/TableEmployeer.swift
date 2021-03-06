//
//  TableEmployeer.swift
//  IOS
//
//  Created by Андрей Гаврилов on 06/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Firebase
import UIKit

class TableEmployeer: UIViewController {
    
    // MARK: - Public Properties
    
    /**
     Модель всех сотрудников
     */
    var data: Company!
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())
    var typeOfShowVC = true
    
    // MARK: - Private Properties
    
    private let identifire = "MyCell"
    private var myId: Int!
    private var titleLabel: UILabel!
    private var tableEmployeer: UITableView!
    private var backgroundView: UIView!
    private var updateButton: UIButton!
    private var countOfDays: Int = 0
    private var labelQuantityHoursWeek = UILabel()
    private var labelQuantityHoursMonth = UILabel()
    private var labelQuantityAllOfHours = UILabel()
    private var labelOfProfileButton = UILabel()
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
        guard UserDefaults.standard.string(forKey: "login") != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
        didUpdateButtonTap()
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
        for i in 0...data.users.count - 1 {
            if data.users[i].info.email == emailUser {
                labelQuantityHoursWeek.text = "\(data.users[i].work.weekHours!)"
                labelQuantityAllOfHours.text = "\(data.users[i].work.totalHours!)"
                labelQuantityHoursMonth.text = "\(data.users[i].work.monthHours!)"
                labelOfProfileButton.text = "\(data.users[i].info.name!) \(data.users[i].info.surname!)"
                myId = i
                countOfDays = data.users[i].days.count
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
                
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        titleLabel = UILabel()
        titleLabel.text = "Статистика"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        let backButton = UIButton()
        backButton.addTarget(self, action: #selector(didBackButtonTap), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(imageLiteralResourceName: "arrowLeft.png"), for: .normal)
        view.addSubview(backButton)

        updateButton = UIButton()
        updateButton.addTarget(self, action: #selector(didUpdateButtonTap), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.setImage(UIImage(imageLiteralResourceName: "update.png"), for: .normal)
        view.addSubview(updateButton)
        
        let profileButton = UIButton()
        profileButton.addTarget(self, action: #selector(didProfileButtonTaped), for: .touchUpInside)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileButton)
        
        let imageOfProfileButton = UIImageView(image: UIImage(named: "employee.png"))
        imageOfProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageOfProfileButton)
        
        labelOfProfileButton.font.withSize(14)
        labelOfProfileButton.textAlignment = .center
        labelOfProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(labelOfProfileButton)
        
        let imageArrowRightProfileButton = UIImageView(image: UIImage(named: "right.png"))
        imageArrowRightProfileButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageArrowRightProfileButton)
        
        let labelHoursWeek = UILabel()
        labelHoursWeek.text = "за неделю"
        labelHoursWeek.font.withSize(14)
        labelHoursWeek.textAlignment = .center
        labelHoursWeek.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursWeek.translatesAutoresizingMaskIntoConstraints = false
        
        labelQuantityHoursWeek.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursWeek.textAlignment = .center
        labelQuantityHoursWeek.translatesAutoresizingMaskIntoConstraints = false
        
        let labelHoursMonth = UILabel()
        labelHoursMonth.text = "за месяц"
        labelHoursMonth.font.withSize(14)
        labelHoursMonth.textAlignment = .center
        labelHoursMonth.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelHoursMonth.translatesAutoresizingMaskIntoConstraints = false
        
        labelQuantityHoursMonth.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityHoursMonth.textAlignment = .center
        labelQuantityHoursMonth.translatesAutoresizingMaskIntoConstraints = false
        
        let labelAllOfHours = UILabel()
        labelAllOfHours.text = "за все время"
        labelAllOfHours.font.withSize(14)
        labelAllOfHours.textAlignment = .center
        labelAllOfHours.textColor = UIColor(red: 0.712, green: 0.712, blue: 0.712, alpha: 1)
        labelAllOfHours.translatesAutoresizingMaskIntoConstraints = false
        
        labelQuantityAllOfHours.font = UIFont.boldSystemFont(ofSize: 18.0)
        labelQuantityAllOfHours.textAlignment = .center
        labelQuantityAllOfHours.translatesAutoresizingMaskIntoConstraints = false
        
        if typeOfShowVC {
            for i in 0...data.users.count - 1 {
                if data.users[i].info.email == UserDefaults.standard.string(forKey: "login") {
                    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
                    leftSwipe.direction = .left
                    self.view.addGestureRecognizer(leftSwipe)
                    labelQuantityHoursWeek.text = "\(data.users[i].work.weekHours!)"
                    labelQuantityAllOfHours.text = "\(data.users[i].work.totalHours!)"
                    labelQuantityHoursMonth.text = "\(data.users[i].work.monthHours!)"
                    labelOfProfileButton.text = "\(data.users[i].info.name!) \(data.users[i].info.surname!)"
                    myId = i
                    countOfDays = data.users[i].days.count
                    backButton.isHidden = true
                }
            }
        }
        
        tableEmployeer = UITableView()
        tableEmployeer.translatesAutoresizingMaskIntoConstraints = false
        tableEmployeer.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        tableEmployeer.delegate = self
        tableEmployeer.dataSource = self
        tableEmployeer.separatorStyle = .none
        view.addSubview(tableEmployeer)
        
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
            
            backButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            
            titleLabel.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            updateButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 32),
            updateButton.widthAnchor.constraint(equalToConstant: 32),
            updateButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            
            profileButton.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            profileButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            profileButton.leftAnchor.constraint(equalTo: view.safeArea.leftAnchor, constant: 25),
            profileButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -25),
            profileButton.heightAnchor.constraint(equalToConstant: 62),
            
            imageOfProfileButton.topAnchor.constraint(equalTo: profileButton.topAnchor),
            imageOfProfileButton.leadingAnchor.constraint(equalTo: profileButton.leadingAnchor),
            imageOfProfileButton.heightAnchor.constraint(equalToConstant: 62),
            imageOfProfileButton.widthAnchor.constraint(equalToConstant: 62),
            
            labelOfProfileButton.centerXAnchor.constraint(equalTo: profileButton.centerXAnchor),
            labelOfProfileButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            
            imageArrowRightProfileButton.heightAnchor.constraint(equalToConstant: 25),
            imageArrowRightProfileButton.widthAnchor.constraint(equalToConstant: 25),
            imageArrowRightProfileButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            imageArrowRightProfileButton.trailingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: -2),
            
            groupStackViewStatistic.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            groupStackViewStatistic.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 44),
            groupStackViewStatistic.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            groupStackViewStatistic.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            
            tableEmployeer.topAnchor.constraint(equalTo: groupStackViewStatistic.bottomAnchor, constant: 25),
            tableEmployeer.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            tableEmployeer.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            tableEmployeer.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor),
        ]
                
    }
    
    @objc private func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        if sender.direction == .left {
            self.tabBarController!.selectedIndex += 1
        }
    }
    
    @objc private func didUpdateButtonTap() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.frame = view.bounds
        activityIndicator.backgroundColor = UIColor(white: 255, alpha: 1)
        
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
            if user != nil {
                let hams = Auth.auth().currentUser?.uid
                let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!)
                self.data.users.removeAll()
                self.oneOfUsers.coming.removeAll()
                self.oneOfUsers.days.removeAll()
                self.oneOfUsers.leaving.removeAll()
                // TODO: Вынести в отдельную функцию
                base.observe(.value, with:  { (snapshot) in
                    guard let value = snapshot.value, snapshot.exists() else { return }
                    let dict: NSDictionary = value as! NSDictionary
                    for (uid, categories) in dict {
                        for (category, fields) in categories as! NSDictionary {
                            if category as? String == "coming" {
                                for (nameOfField, valueOfField) in fields as! NSDictionary {
                                    if !(self.dateNow(baseDate: nameOfField as! String)) {
                                        base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("coming").child(nameOfField as! String).removeValue()
                                    } else {
                                        self.oneOfUsers.days.append(nameOfField as! String)
                                        self.oneOfUsers.coming.append(valueOfField as! String)
                                    }
                                }
                            }
                            if category as? String == "leaving" {
                                for (nameOfField, valueOfField) in fields as! NSDictionary {
                                    if !(self.dateNow(baseDate: nameOfField as! String)) {
                                        base.child(UserDefaults.standard.string(forKey: "company")!).child(hams!).child("leaving").child(nameOfField as! String).removeValue()
                                    } else {
                                        self.oneOfUsers.leaving.append(valueOfField as! String)
                                    }
                                }
                            }
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
                                if nameOfField as? String == "patronymic" {
                                    self.oneOfUsers.info.patronymic = valueOfField as? String
                                    continue
                                }
                                if nameOfField as? String == "wifi" {
                                    self.oneOfUsers.work.wifi = valueOfField as? String
                                    continue
                                }
                                if nameOfField as? String == "monthHours" {
                                    self.oneOfUsers.work.monthHours = valueOfField as? Double
                                    continue
                                }
                                if nameOfField as? String == "totalHours" {
                                    self.oneOfUsers.work.totalHours = valueOfField as? Double
                                    continue
                                }
                                if nameOfField as? String == "weekHours" {
                                    self.oneOfUsers.work.weekHours = valueOfField as? Double
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
                        self.oneOfUsers.coming.removeAll()
                        self.oneOfUsers.days.removeAll()
                        self.oneOfUsers.leaving.removeAll()
                    }
                    self.tableEmployeer.reloadData()
                })
                activityIndicator.stopAnimating()
            } else {
                print(error as Any)
                activityIndicator.stopAnimating()
            }
        }        
    }
        
    @objc private func didProfileButtonTaped() {
//        for i in 0...data.users.count - 1 {
//            if data.users[i].info.email == UserDefaults.standard.string(forKey: "login")! {
                let vc = ProfileEmployeer(emailUser: data.users[myId].info.email!, data: data)
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .coverVertical
                self.present(vc, animated: true, completion: nil)
//            }
//        }
    }
        
    private func dateNow(baseDate: String) -> Bool {
        var dateNow: String
        switch Calendar.current.component(.month, from: Date()) {
        case 1:
            dateNow = "\(Calendar.current.component(.day, from: Date())) january"
        case 2:
            dateNow = "\(Calendar.current.component(.day, from: Date())) february"
        case 3:
            dateNow = "\(Calendar.current.component(.day, from: Date())) march"
        case 4:
            dateNow = "\(Calendar.current.component(.day, from: Date())) april"
        case 5:
            dateNow = "\(Calendar.current.component(.day, from: Date())) may"
        case 6:
            dateNow = "\(Calendar.current.component(.day, from: Date())) june"
        case 7:
            dateNow = "\(Calendar.current.component(.day, from: Date())) july"
        case 8:
            dateNow = "\(Calendar.current.component(.day, from: Date())) august"
        case 9:
            dateNow = "\(Calendar.current.component(.day, from: Date())) september"
        case 10:
            dateNow = "\(Calendar.current.component(.day, from: Date())) october"
        case 11:
            dateNow = "\(Calendar.current.component(.day, from: Date())) november"
        case 12:
            dateNow = "\(Calendar.current.component(.day, from: Date())) december"
        default:
            dateNow = "0"
            // Невозможное невозможно
        }
        let separatedBaseDate = baseDate.components(separatedBy: [" "])
        let separatedNowDate = dateNow.components(separatedBy: [" "])
        
        if separatedBaseDate[1] == separatedNowDate[1] {
            if Int(separatedNowDate[0])! - Int(separatedBaseDate[0])! > 7 {
                return false
            }
        } else {
            return false
        }
        return true
    }
    
    @objc private func didBackButtonTap() {
        self.dismiss(animated: true, completion: nil)
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
        return countOfDays
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .default, reuseIdentifier: "MyCell", data: data, indexPath: indexPath, accessoryType: .none, id: myId)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
}
