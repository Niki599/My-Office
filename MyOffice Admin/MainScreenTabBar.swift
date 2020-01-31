//
//  MainMenu.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class MainScreenTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        selectedIndex = 1
        tabBar.clipsToBounds = true
        tabBar.backgroundImage = UIImage()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc2 = storyboard.instantiateViewController(withIdentifier: "MainScreen")
        let vc1 = storyboard.instantiateViewController(withIdentifier: "ProfileEmployeer")
        let vc3 = storyboard.instantiateViewController(withIdentifier: "TableEmployeer")
//        if (UserDefaults.standard.bool(forKey: "admin")) {
//            self.viewControllers = [vc1, vc2, vc3]
//        } else {
//            self.viewControllers = [vc2, vc1, vc3]
//        }
//        self.navigationItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
