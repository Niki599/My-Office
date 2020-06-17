//
//  TableEmployeers.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 15/02/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import UIKit
import Firebase

class TableEmployeers: UIViewController {
    
    // MARK: - Public Methods
    
    /**
     Модель всех сотрудников
     */
    var data: Company!
    var oneOfUsers: User = User(info: InfoUser(), work: WorkUser())

    // MARK: - Private Properties
    
    private var titleLabel: UILabel!
    private var updateButton: UIButton!
    private var addEmployee: UIButton!
    private var dateLabel: UILabel!
    private var tableEmployeers: UITableView!
    private var constraints: [NSLayoutConstraint]!
    private var totalWorkingEmployeers = 0
    private var totalEmployeers = 0
    private let identifire = "MyCell"

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        staffCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard UserDefaults.standard.string(forKey: "login") != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        super.viewWillAppear(animated)
        didUpdateButtonTap()
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Properties
    
    private func setupViews() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
        
        titleLabel = UILabel()
        titleLabel.text = "Штат сотрудников"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
        updateButton = UIButton()
        updateButton.addTarget(self, action: #selector(didUpdateButtonTap), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.setImage(UIImage(imageLiteralResourceName: "update.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        view.addSubview(updateButton)
        
        addEmployee = UIButton()
        addEmployee.addTarget(self, action: #selector(didCreateEmployyButtonTap), for: .touchUpInside)
        addEmployee.translatesAutoresizingMaskIntoConstraints = false
        addEmployee.setImage(UIImage(imageLiteralResourceName: "addRound.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        view.addSubview(addEmployee)
        
        tableEmployeers = UITableView()
        tableEmployeers.translatesAutoresizingMaskIntoConstraints = false
        tableEmployeers.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        tableEmployeers.delegate = self
        tableEmployeers.dataSource = self
        tableEmployeers.separatorStyle = .none
        view.addSubview(tableEmployeers)
        
        constraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            updateButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 32),
            updateButton.widthAnchor.constraint(equalToConstant: 32),
            updateButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            
            addEmployee.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            addEmployee.heightAnchor.constraint(equalToConstant: 32),
            addEmployee.widthAnchor.constraint(equalToConstant: 32),
            addEmployee.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            
            tableEmployeers.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            tableEmployeers.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            tableEmployeers.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            tableEmployeers.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor),

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
                    self.staffCount()
                    self.tableEmployeers.reloadData()
                })
                activityIndicator.stopAnimating()
            } else {
                print(error as Any)
                activityIndicator.stopAnimating()
            }
        }        
    }
    
    @objc private func didCreateEmployyButtonTap() {
        
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") as! SignUp
        signUpVC.typeOfSignUp = false
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .flipHorizontal
        self.present(signUpVC, animated: true, completion: nil)
        
    }
    
    private func staffCount() {
        totalWorkingEmployeers = 0
        totalEmployeers = 0
        for user in data.users {
            totalEmployeers += 1
            if user.work.check! {
                totalWorkingEmployeers += 1
            }
        }
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
            dateNow = "0" // Невозможное невозможно
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

    
}

extension TableEmployeers : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let labelHeader = UILabel()
        labelHeader.textColor = .black
        switch Calendar.current.component(.month, from: Date()) {
        case 1:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) января"
        case 2:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) февраля"
        case 3:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) марта"
        case 4:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) апреля"
        case 5:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) мая"
        case 6:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) июня"
        case 7:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) июля"
        case 8:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) августа"
        case 9:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) сентября"
        case 10:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) октября"
        case 11:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) ноября"
        case 12:
            labelHeader.text = "Сегодня: \((Calendar.current.component(.day, from: Date()))) декабря"
        default:
            print("Что сейчас происходит?")
        }
        labelHeader.textAlignment = .center
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        
        /**
         StackView здесь для расположения этого всего по центру
         */
        let stackViewHeader = UIStackView(arrangedSubviews: [labelHeader])
        stackViewHeader.axis = .horizontal
        stackViewHeader.alignment = .center
        stackViewHeader.distribution = .fillEqually
        
        return stackViewHeader
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let labelFooter = UILabel()
        labelFooter.textColor = .black
        labelFooter.textAlignment = .left
        labelFooter.numberOfLines = 3
        labelFooter.text = "В работе: \(totalWorkingEmployeers)\nВсего сотрудников: \(totalEmployeers)\nОтсутствуют: \(totalEmployeers - totalWorkingEmployeers)"
        labelFooter.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewFooter = UIStackView(arrangedSubviews: [labelFooter])
        stackViewFooter.axis = .horizontal
        stackViewFooter.alignment = .center
        stackViewFooter.distribution = .fillEqually
        
        return stackViewFooter
    }
    
}

extension TableEmployeers : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableViewCell(style: .default, reuseIdentifier: "MyCell", data: data, indexPath: indexPath, accessoryType: .disclosureIndicator)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TableEmployeer(emailUser: data.users[indexPath.row].info.email!, data: data)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true, completion: nil)
    }
        
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {

            // remove the item from the data model
            data.users.remove(at: indexPath.row)

            // delete the table view row
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            staffCount()

//            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
//                let base = Database.database().reference().child(UserDefaults.standard.string(forKey: "company")!)
//                var uidDeleted: String?
//                base.observe(.value, with:  { (snapshot) in
//                    guard let value = snapshot.value, snapshot.exists() else { return }
//                    let dict: NSDictionary = value as! NSDictionary
//                    for (uid, categories) in dict as! NSDictionary {
//                        for (category, fields) in categories as! NSDictionary {
//                            for (nameOfField, valueOfField) in fields as! NSDictionary {
//                                if nameOfField as? String == "email" {
//                                    if self.data.users[indexPath.row].info.email == valueOfField as? String {
//                                        uidDeleted = uid as? String
//                                        break
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    base.child(uidDeleted!).removeValue()
//                    self.data.users.remove(at: indexPath.row)
//                    // delete the table view row
//
//                    tableView.deleteRows(at: [indexPath], with: .automatic)
//                    self.staffCount()
//                })
//            }
//            print(Auth.auth().currentUser?.email)
        } else if editingStyle == .insert {
            
        }
    }
    
}
