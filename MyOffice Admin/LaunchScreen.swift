//
//  LaunchScreen.swift
//  MyOffice Admin
//
//  Created by Nikita on 30/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class LaunchScreen: UIViewController {
    
    var timer = Timer()
    let timeInterval = 3.0

    override func viewDidLoad() {
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(nextView), userInfo: nil, repeats: true)
        
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func nextView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SignIn") as! SignIn
        present(viewController, animated: true, completion: nil)
    }

}
