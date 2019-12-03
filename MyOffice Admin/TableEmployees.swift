//
//  TableEmployeer.swift
//  IOS
//
//  Created by Андрей Гаврилов on 06/11/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation
import Firebase

class TableEmployyes: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var check = [Int]()
    var email = [String]()
    var name = [String]()
    var phone = [String]()
    var surname = [String]()
    //DataSource
    var data = ["","","","",""]
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
                        
//        Auth.auth().signIn(withEmail: "b@mail.ru", password: "123456") { (user, error) in
//            let hams = Auth.auth().currentUser?.uid
//            print(hams)
//            let base = Database.database().reference().child("users").child(hams!)
//            base.updateChildValues(["check":false])
//            print(base)
//            base.observeSingleEvent(of: .value, with: { (snapshot) in
//
//                let userDict = snapshot.value as! [String: Any]
//
//                let email = userDict["name"] as! String
//                let yetki = userDict["surname"] as! String
//                print("email: \(email)  yetki: \(yetki)")
//            })
//        }
    
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    //Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
//    @IBOutlet weak var tableEmployeer: UITableView!
    var tableEmployeer = UITableView()
    let identifire = "MyCell"


//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return 2
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().signIn(withEmail: "b@mail.ru", password: "123456") { (user, error) in
                    let hams = Auth.auth().currentUser?.uid
        //          print(hams)
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
        createTable()
        
        
//        tableEmployeer.rowHeight = 45
//        tableEmployeer.numberOfRows(inSection: 15)
//        tableEmployeer.sectionFooterHeight = 22
//        tableEmployeer.sectionHeaderHeight = 22
//        tableEmployeer.isScrollEnabled = true
//        tableEmployeer.showsVerticalScrollIndicator = true
//        tableEmployeer.isUserInteractionEnabled = true
//        tableEmployeer.bounces = true

    
}
    
    func createTable() {
        self.tableEmployeer = UITableView(frame: CGRect.init(x: 0, y: 60, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 150), style: .plain)
        tableEmployeer.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        self.tableEmployeer.delegate = self
        self.tableEmployeer.dataSource = self
        
        tableEmployeer.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(tableEmployeer)
    }
    
    
    @IBAction func buttonBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Check")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func info(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Info")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

