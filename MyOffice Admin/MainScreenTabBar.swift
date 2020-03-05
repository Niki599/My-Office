//
//  MainMenu.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit

class MainScreenTabBar: UITabBarController {
    
    // MARK: - Public Properties
    
    var data: Company!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        let VCTableEmployeer = self.storyboard?.instantiateViewController(withIdentifier: "TableEmployeer") as! TableEmployeer
        let VCProfileEmployeer = self.storyboard?.instantiateViewController(withIdentifier: "ProfileEmployeer") as! ProfileEmployeer
        let VCMainScreen = self.storyboard?.instantiateViewController(withIdentifier: "MainScreen") as! MainScreen
        let VCTableEmployeers = self.storyboard?.instantiateViewController(withIdentifier: "TableEmployeers") as! TableEmployeers
        /**
            Передача по viewControllers модели копании
         */
        VCTableEmployeer.data = data
        VCMainScreen.data = data
        VCProfileEmployeer.data = data
        VCTableEmployeers.data = data
        /**
            Убираю границу tabBarItem
        */
        tabBar.clipsToBounds = true
        /**
            Изменяю его цвет на белый
         */
        tabBar.backgroundImage = UIImage()
        
        if (UserDefaults.standard.bool(forKey: "admin")) {
            self.viewControllers = [VCTableEmployeers, VCMainScreen, VCProfileEmployeer]
        } else {
            self.viewControllers = [VCTableEmployeer, VCMainScreen, VCProfileEmployeer]
        }
        /**
            Сделать это сейчас, ибо все крашится, если поставить это в начало, потому как настройка происходит потом (или я ошибся)
        */
        super.viewDidLoad()
        /**
            Открыто главное окно
         */
        selectedIndex = 1
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
