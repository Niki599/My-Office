//
//  TableEmployeers.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 15/02/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class TableEmployeers: UIViewController {
    
    // MARK: - Public Methods
    
    /**
     Модель всех сотрудников
     */
    var data: Company!
    
    // MARK: - Private Properties
    
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var tableEmployeers: UITableView!
    private var constraints: [NSLayoutConstraint]!
    private var stackViewHeader: UIStackView!
    private var totalWorkingEmployeers: Int!
    private var totalEmployeers: Int!
    private let identifire = "MyCell"

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Properties
    
    private func setupViews() {
        
        titleLabel = UILabel()
        titleLabel.text = "Мои данные"
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
        
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
            
            tableEmployeers.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            tableEmployeers.leadingAnchor.constraint(equalTo: view.safeArea.leadingAnchor, constant: 10),
            tableEmployeers.trailingAnchor.constraint(equalTo: view.safeArea.trailingAnchor, constant: -10),
            tableEmployeers.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor),

        ]
        
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
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " января"
        case 2:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " февраля"
        case 3:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " марта"
        case 4:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " апреля"
        case 5:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " мая"
        case 6:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " июня"
        case 7:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " июля"
        case 8:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " августа"
        case 9:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " сентября"
        case 10:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " октября"
        case 11:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " ноября"
        case 12:
            labelHeader.text = "Сегодня: " + String(Calendar.current.component(.day, from: Date())) + " декабря"
        default:
            print("Что сейчас происходит?")//Не вызовется, можно засунуть сюда "case 12:", но я этого не сделал
        }
        labelHeader.textAlignment = .center
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        
        return labelHeader
        
    }
}

extension TableEmployeers : UITableViewDataSource {
    
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
        let cell = TableViewCell(style: .default, reuseIdentifier: "MyCell", data: data)
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
    
    /**
     Нажатие на (i)
     */
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("hui")
    }
    
}
