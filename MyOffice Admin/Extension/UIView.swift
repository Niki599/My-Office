//
//  UIView.swift
//  MyOffice Admin
//
//  Created by Nikita on 09/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit

extension UIView {
    
    var safeArea: UILayoutGuide {
        get {
            if #available(iOS 11.0, *) {
                return self.safeAreaLayoutGuide
            }
            return self.layoutMarginsGuide
        }
    }
}
    
extension String {
    
    func toDate(with format: String = "HH:MM") -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
}
