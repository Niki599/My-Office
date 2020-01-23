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
    
    var check = [Int]()
    var email = [String]()
    var name = [String]()
    var phone = [String]()
    var surname = [String]()
    var data = ["", "", "", "", ""]
    let identifire = "MyCell"
    
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
        return label
    }()

    private lazy var labelHeaderComming: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Приход"
        return label
    }()
    
    private lazy var labelHeaderLeaving: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Уход"
        return label
    }()
    
    private lazy var labelHeaderTimeOfWorking: UILabel = {
        var label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Roboto-Medium", size: 12)
        label.textAlignment = .center
        label.text = "Всего"
        return label
    }()


//    private lazy var labelDate: UILabel = {
//        var label = UILabel()
//        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        label.font = UIFont.italicSystemFont(ofSize: 12)
//        label.textAlignment = .center
//        label.text = "3 ноября"
//        return label
//    }()
//    private lazy var labelComming: UILabel = {
//        var label = UILabel()
//        label.textColor = UIColor(red: 0, green: 0.721, blue: 0.029, alpha: 1)
//        label.font = UIFont.italicSystemFont(ofSize: 12)
//        label.textAlignment = .center
//        label.text = "10:30"
//        return label
//    }()
//    private lazy var labelLeaving: UILabel = {
//        var label = UILabel()
//        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        label.font = UIFont.italicSystemFont(ofSize: 12)
//        label.textAlignment = .center
//        label.text = "19:45"
//        return label
//    }()
//    private lazy var labelTimeOfWorking: UILabel = {
//        var label = UILabel()
//        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        label.font = UIFont.italicSystemFont(ofSize: 12)
//        label.textAlignment = .center
//        label.text = "9.22 ч"
//        return label
//    }()


    
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
        
        constraints = [
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            titleTable.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            titleTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            tableEmployeer.topAnchor.constraint(equalTo: titleTable.bottomAnchor, constant: 25),
            tableEmployeer.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            tableEmployeer.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            tableEmployeer.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor),
            
            updateButton.centerYAnchor.constraint(equalTo: titleTable.centerYAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            updateButton.widthAnchor.constraint(equalToConstant: 40),
            updateButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -5)
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

        let stackViewHeader = UIStackView(arrangedSubviews: [labelHeaderDate, labelHeaderComming, labelHeaderLeaving, labelHeaderTimeOfWorking])
        
        stackViewHeader.axis = .horizontal
        stackViewHeader.distribution = .fillEqually
        stackViewHeader.alignment = .center
        stackViewHeader.backgroundColor = .black
//        let headerView = UIView()
//        headerView.addSubview(stackViewHeader)
//        headerView.backgroundColor = .green
        
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
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
//        let cell = UITableViewCell(style: .default, reuseIdentifier: identifire)
//        cell.textLabel?.text = data[indexPath.row]
        let labelDate = UILabel()
        labelDate.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelDate.font = UIFont.italicSystemFont(ofSize: 13)
        labelDate.textAlignment = .center
        labelDate.numberOfLines = 0
        labelDate.text = "3 ноября"
        let labelComming = UILabel()
        labelComming.textColor = UIColor(red: 0, green: 0.721, blue: 0.029, alpha: 1)
        labelComming.font = UIFont.italicSystemFont(ofSize: 13)
        labelComming.textAlignment = .center
        labelComming.text = "10:30"
        let labelLeaving = UILabel()
        labelLeaving.textColor = UIColor(red: 0.721, green: 0.029, blue: 0, alpha: 1)
        labelLeaving.font = UIFont.italicSystemFont(ofSize: 13)
        labelLeaving.textAlignment = .center
        labelLeaving.text = "19:45"
        let labelTimeOfWorking = UILabel()
        labelTimeOfWorking.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        labelTimeOfWorking.font = UIFont.italicSystemFont(ofSize: 13)
        labelTimeOfWorking.textAlignment = .center
        labelTimeOfWorking.text = "9.22 ч"
        // Зеленый фон нажатия
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.954, green: 1, blue: 0.956, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        
        let stackViewCell = UIStackView(arrangedSubviews: [labelDate, labelComming, labelLeaving, labelTimeOfWorking])
        stackViewCell.axis = .horizontal
        stackViewCell.alignment = .center
        stackViewCell.distribution = .fillEqually
        stackViewCell.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(stackViewCell)
        
        stackViewCell.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor).isActive = true
        stackViewCell.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
        cell.contentView.trailingAnchor.constraint(equalTo: stackViewCell.trailingAnchor).isActive = true
        cell.contentView.bottomAnchor.constraint(equalTo: stackViewCell.bottomAnchor).isActive = true
//        cell.accessoryType = .detailDisclosureButton
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
    
extension String {
    
    func toDate(with format: String = "HH:MM") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
}
