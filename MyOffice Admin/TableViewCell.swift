//
//  TableViewCell.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 21/01/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: - Lifecycle
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, data: Company, indexPath: IndexPath, accessoryType: UITableViewCell.AccessoryType) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        var stackViewCell: UIStackView!
        
        let labelFirst = UILabel()
        labelFirst.font = UIFont.italicSystemFont(ofSize: 13)
        labelFirst.numberOfLines = 0
        
        /**
         Заполнение таблицы данными в зависимости от типа таблицы, если на ячейку можно нажать, то таблица админа, иначе -- нет
         */
        
        if accessoryType == .none {
            labelFirst.textAlignment = .center

            let labelSecond = UILabel()
            labelSecond.font = UIFont.italicSystemFont(ofSize: 13)
            labelSecond.textAlignment = .center
            labelSecond.numberOfLines = 0
            
            let labelThrid = UILabel()
            labelThrid.font = UIFont.italicSystemFont(ofSize: 13)
            labelThrid.textAlignment = .center
            labelThrid.numberOfLines = 0
            
            let labelFourth = UILabel()
            labelFourth.font = UIFont.italicSystemFont(ofSize: 13)
            labelFourth.textAlignment = .center
            labelFourth.numberOfLines = 0

            labelFirst.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            labelSecond.textColor = UIColor(red: 0, green: 0.721, blue: 0.029, alpha: 1)
            labelThrid.textColor = UIColor(red: 0.721, green: 0.029, blue: 0, alpha: 1)
            labelFourth.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

            labelFirst.text = data.users[indexPath.row].info.name
            labelSecond.text = data.users[indexPath.row].work.coming
            labelThrid.text = data.users[indexPath.row].work.leaving
            labelFourth.text = "\(data.users[indexPath.row].work.weekHours ?? 0) ч"
            
            stackViewCell = UIStackView(arrangedSubviews: [labelFirst, labelSecond, labelThrid, labelFourth])
        } else {
            labelFirst.textAlignment = .left

            labelFirst.text = "\(data.users[indexPath.row].info.surname ?? "null") \(data.users[indexPath.row].info.name ?? "null") \(data.users[indexPath.row].info.patronymic ?? "null")"
            
            stackViewCell = UIStackView(arrangedSubviews: [labelFirst])
        }
        
        // Зеленый фон нажатия на таблицу
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.954, green: 1, blue: 0.956, alpha: 1)
        selectedBackgroundView = backgroundView
        
        stackViewCell.axis = .horizontal
        stackViewCell.alignment = .center
        stackViewCell.distribution = .fillEqually
        stackViewCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackViewCell)
        
        stackViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackViewCell.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: stackViewCell.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: stackViewCell.bottomAnchor).isActive = true
        self.accessoryType = accessoryType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
