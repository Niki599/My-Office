//
//  MainScreen.swift
//  MyOffice Admin
//
//  Created by Nikita on 24/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import UIKit

class MainScreen: UIViewController {
    
    private var avatarUser: UIImageView!
    private var connectionButton: UIButton!
    private var exitButton: UIButton!
    private var visitsTableButton: UIButton!
    private var infoConnection: UILabel!
    private var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        
        let logoImage = UIImage(imageLiteralResourceName: "employee.png").resizableImage(withCapInsets: .zero, resizingMode: .stretch)
        
        backgroundView = UIView()
        backgroundView.backgroundColor = .white
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundView)
        
        avatarUser = UIImageView(image: logoImage)
        avatarUser.layer.cornerRadius = 0.5
        avatarUser.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(avatarUser)
        
        connectionButton = UIButton()
        connectionButton.layer.borderWidth = 1
        connectionButton.layer.cornerRadius = 5
        connectionButton.setTitle("Подключиться", for: .normal)
        connectionButton.setTitleColor(.black, for: .normal)
        connectionButton.setTitleColor(.white, for: .normal)
        connectionButton.backgroundColor = UIColor.init(red: 0.0/255.0, green: 50.0/255.0, blue: 233.0/255.0, alpha: 1)
        connectionButton.layer.borderColor = UIColor.init(red: 6.0/255.0, green: 150.0/255.0, blue: 254.0/255.0, alpha: 1).cgColor
        connectionButton.translatesAutoresizingMaskIntoConstraints = false
//        connectionButton.addTarget(self, action:#selector(connectionButton), for: .touchUpInside)
        connectionButton.clipsToBounds = true
        view.addSubview(connectionButton)
        
        exitButton = UIButton()
        exitButton.layer.borderWidth = 1
        exitButton.layer.cornerRadius = 5
        exitButton.setTitle("Выход", for: .normal)
        exitButton.setTitleColor(.black, for: .normal)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.backgroundColor = UIColor.red
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.addTarget(self, action:#selector(exitAction), for: .touchUpInside)
        exitButton.clipsToBounds = true
        view.addSubview(exitButton)
        
        infoConnection = UILabel()
        infoConnection.translatesAutoresizingMaskIntoConstraints = false
        infoConnection.text = "Отсутствует"
        infoConnection.textAlignment = .center
        infoConnection.textColor = .red
        view.addSubview(infoConnection)
        
    }
    
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            avatarUser.topAnchor.constraint(equalTo: self.view.safeArea.centerYAnchor,constant: -100),
            avatarUser.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            avatarUser.heightAnchor.constraint(equalToConstant: 120),
            avatarUser.widthAnchor.constraint(equalTo: avatarUser.heightAnchor),
            
            infoConnection.topAnchor.constraint(equalTo: avatarUser.bottomAnchor, constant: 14),
            infoConnection.leadingAnchor.constraint(equalTo: avatarUser.leadingAnchor,constant: -10),
            infoConnection.trailingAnchor.constraint(equalTo: avatarUser.trailingAnchor,constant: 10),
            infoConnection.heightAnchor.constraint(equalToConstant: 40),
            
            connectionButton.topAnchor.constraint(equalTo: infoConnection.bottomAnchor, constant: 14),
            connectionButton.leadingAnchor.constraint(equalTo: avatarUser.leadingAnchor,constant: -10),
            connectionButton.trailingAnchor.constraint(equalTo: avatarUser.trailingAnchor,constant: 10),
            connectionButton.heightAnchor.constraint(equalToConstant: 40),
            
            exitButton.topAnchor.constraint(equalTo: connectionButton.bottomAnchor, constant: 14),
            exitButton.leadingAnchor.constraint(equalTo: avatarUser.leadingAnchor,constant: -10),
            exitButton.trailingAnchor.constraint(equalTo: avatarUser.trailingAnchor,constant: 10),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            
//            infoConnection.topAnchor.constraint(equalTo: <#T##NSLayoutAnchor<NSLayoutYAxisAnchor>#>)
            
        ])
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.viewDidLayoutSubviews()
    }
    
    @objc func exitAction() {
        self.navigationController?.popViewController(animated: true)
        UserDefaults.standard.set(false, forKey: "dataAvailability")
    }
    
}
