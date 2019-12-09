//
//  TextField.swift
//  MyOffice Admin
//
//  Created by Nikita on 03/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit

extension UITextField
{
    open override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.init(red: 6.0/255.0, green: 150.0/255.0, blue: 254.0/255.0, alpha: 1).cgColor
        self.layer.masksToBounds = true
    }
}
