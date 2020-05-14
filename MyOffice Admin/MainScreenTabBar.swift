//
//  MainMenu.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 30/11/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit

class MainScreenTabBar: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: - Public Properties
    
    var data: Company!
    var screenWidth = UIScreen.main.bounds.width
    var screenHeight = UIScreen.main.bounds.height

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
        
        self.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let fromView = selectedViewController?.view
        let toView = viewController.view
         
        if fromView !== toView {
            UIView.transition(from: fromView!, to: toView!, duration: 0.5, options: [.transitionCrossDissolve], completion: nil)
        } else {
             
        }
         
        return true
    }
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        animateSliding(fromController: selectedViewController, toController: viewController)
//        return false
//    }
    
//    func animateSliding(fromController: UIViewController?, toController: UIViewController?) {
//
//        guard let fromController = fromController, let toController = toController  else { return }
//        guard let fromIndex = viewControllers?.index(of: fromController),
//            let toIndex = viewControllers?.index(of: toController) else { return }
//        guard fromIndex != toIndex else { return }
//
//        let fromView = fromController.view!
//        let toView = toController.view!
//        let viewSize = fromView.frame
//        let scrollRight = fromIndex < toIndex
//        fromView.superview?.addSubview(toView)
//        toView.frame = CGRect(x: scrollRight ? screenWidth : -screenWidth,
//                              y: viewSize.origin.y,
//                              width: screenWidth,
//                              height: viewSize.height)
//
//        func animate() {
//            fromView.frame = CGRect(x: scrollRight ? -screenWidth : screenWidth,
//                                    y: viewSize.origin.y,
//                                    width: screenWidth,
//                                    height: viewSize.height)
//            toView.frame = CGRect(x: 0,
//                                    y: viewSize.origin.y,
//                                    width: screenWidth,
//                                    height: viewSize.height)
//        }
//
//        func finished(_ completed: Bool) {
//            fromView.removeFromSuperview()
//            selectedIndex = toIndex
//        }
//
//        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseInOut,
//                       animations: animate, completion: finished)
//    }
    
}
