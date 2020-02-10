//
//  TableViewCell.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 21/01/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, data: Company) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        
        // Зеленый фон нажатия на таблицу
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(red: 0.954, green: 1, blue: 0.956, alpha: 1)
        selectedBackgroundView = backgroundView
        
        let stackViewCell = UIStackView(arrangedSubviews: [labelDate, labelComming, labelLeaving, labelTimeOfWorking])
        stackViewCell.axis = .horizontal
        stackViewCell.alignment = .center
        stackViewCell.distribution = .fillEqually
        stackViewCell.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackViewCell)
        
        stackViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        stackViewCell.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: stackViewCell.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: stackViewCell.bottomAnchor).isActive = true
        //        cell.accessoryType = .detailDisclosureButton
        
}
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
