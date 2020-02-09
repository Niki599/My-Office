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
    
    // MARK: - Public Properties
    
    var data: Company!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedIndex = 1
        
        tabBar.clipsToBounds = true
        tabBar.backgroundImage = UIImage()
        
        let VCTableEmployeer = self.storyboard?.instantiateViewController(withIdentifier: "TableEmployeer") as! TableEmployeer
        let VCProfileEmployeer = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEmployeer") as! ProfileEmployeer
        let VCMainScreen = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
        
        /**
            Передача по viewControllers модели копании
         */
        VCTableEmployeer.data1 = data
        VCMainScreen.data = data
        VCProfileEmployeer.data = data
        
        // TODO: Добавить зависимость от переменной "Админ"
        if (UserDefaults.standard.bool(forKey: "admin")) {
            self.viewControllers = [VCTableEmployeer, VCMainScreen, VCProfileEmployeer]
        } else {
            self.viewControllers = [VCTableEmployeer, VCMainScreen, VCProfileEmployeer]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
