//
//  TableEmployeer.swift
//  IOS
//
//  Created by Андрей Гаврилов on 06/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Firebase
import UIKit

class TableEmployyes: UIViewController {
    
    var check = [Int]()
    var email = [String]()
    var name = [String]()
    var phone = [String]()
    var surname = [String]()
    var data = ["","","","",""]
    let identifire = "MyCell"
    
    var titleTable: UILabel!
    var tableEmployeer: UITableView!
    var backgroundView: UIView!
    var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestDate()
        setupView()
    }
    
    func setupView() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        titleTable = UILabel()
        titleTable.text = "Таблица сотрудников"
        titleTable.translatesAutoresizingMaskIntoConstraints = false
        titleTable.textAlignment = .center
        view.addSubview(titleTable)
        
        tableEmployeer = UITableView()
        tableEmployeer.translatesAutoresizingMaskIntoConstraints = false
        tableEmployeer.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        tableEmployeer.delegate = self
        tableEmployeer.dataSource = self
        tableEmployeer.layer.borderWidth = 1.0
        view.addSubview(tableEmployeer)
        
        updateButton = UIButton()
        updateButton.addTarget(self, action: #selector(updateTable), for: .touchUpInside)
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        updateButton.setImage(UIImage(imageLiteralResourceName: "update.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch), for: .normal)
        view.addSubview(updateButton)
    }
    
    @objc func updateTable () {
        requestDate()
    }
    
    func requestDate() {
        Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "login")!, password: UserDefaults.standard.string(forKey: "password")!) { (user, error) in
            self.data = ["","","","",""]
            self.name.removeAll()
            self.surname.removeAll()
            self.check.removeAll()
            let base = Database.database().reference().child("users")
            print(base)
            base.observe(.value, with:  { (snapshot) in
                guard let value = snapshot.value, snapshot.exists() else { return }
                let dict: NSDictionary = value as! NSDictionary
                for (_, item) in dict {
                    for (k, i) in item as! NSDictionary {
                        if (k as? String == "name") {
                            self.name.append((i as! String))
                            print(i)
                        }
                        if (k as? String == "surname") {
                            self.surname.append((i as! String))
                            print(i)
                        }
                        if (k as? String == "check") {
                            self.check.append(i as! Int)
                            print(i)
                        }
                    }
                }
                for i in 0...4 {
                    self.data[i] = self.name[i] + " " + self.surname[i] + " "
                    if  String(self.check[i]) == "0" {
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
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            titleTable.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 25),
            titleTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 1.5),
            
            tableEmployeer.topAnchor.constraint(equalTo: titleTable.bottomAnchor, constant: 25),
            tableEmployeer.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor),
            tableEmployeer.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor),
            tableEmployeer.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor),
            
            updateButton.centerYAnchor.constraint(equalTo: titleTable.centerYAnchor),
            updateButton.heightAnchor.constraint(equalToConstant: 40),
            updateButton.widthAnchor.constraint(equalToConstant: 40),
            updateButton.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -5)
            
        ])
    }
    
    func info() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Info")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension TableEmployyes : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension TableEmployyes : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}

