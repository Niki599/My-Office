//
//  ControlView.swift
//  MyOffice Admin
//
//  Created by Nikita on 19/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class ControlView: UIViewController {
    
    @IBAction func buttonBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SignIn")
        self.navigationController?.pushViewController(vc, animated: true)
        UserDefaults.standard.set(false, forKey: "dataAvailability")
    }
}
