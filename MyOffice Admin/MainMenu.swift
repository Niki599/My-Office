//
//  MainMenu.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class MainMenu: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MainMenu")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
