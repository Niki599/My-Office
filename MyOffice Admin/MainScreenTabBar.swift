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
        let VCTableEmployeer = self.storyboard?.instantiateViewController(withIdentifier: "TableEmployeer") as! TableEmployeer
        let VCProfileEmployeer = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEmployeer") as! ProfileEmployeer
        let VCMainScreen = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
        
        /**
            Передача по viewControllers модели копании
         */
        VCTableEmployeer.data = data
        VCMainScreen.data = data
        VCProfileEmployeer.data = data
        
        tabBar.clipsToBounds = true
        tabBar.backgroundImage = UIImage()
        
        // TODO: Добавить зависимость от переменной "Админ" на окно таблицы
        if (UserDefaults.standard.bool(forKey: "admin")) {
            self.viewControllers = [VCTableEmployeer, VCMainScreen, VCProfileEmployeer]
        } else {
            self.viewControllers = [VCTableEmployeer, VCMainScreen, VCProfileEmployeer]
        }

        super.viewDidLoad()
        
        selectedIndex = 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
