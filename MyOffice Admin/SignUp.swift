//
//  SignUp.swift
//  MyOffice Admin
//
//  Created by Андрей Гаврилов on 11/02/2020.
//  Copyright © 2020 Андрей Гаврилов. All rights reserved.
//

import Foundation
import UIKit

class SignUp: UIViewController {
    
    // MARK: - Public Properties
    
    
    
    // MARK: - Private Properties
    private var  companyView: UIView!
    private var constraints: [NSLayoutConstraint]!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        //Тап по экрану, чтобы спрятать клаву
        let gesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(gesture)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(constraints)
    }

    
    // MARK: - Public Methods
    
    
    
    // MARK: - Private Methods
    
    private func setupView() {
                
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let space = screenWidth/2
        
        view.backgroundColor = .black
        
        companyView = UIView()
        companyView.layer.cornerRadius = 20
        companyView.backgroundColor = .white
        companyView.translatesAutoresizingMaskIntoConstraints = false
        companyView.alpha = 0.8
        view.addSubview(companyView)
        
        let companyLabel = UILabel()
        companyLabel.textColor = .black
        companyLabel.text = "Имя вашей компании"
        companyLabel.textAlignment = .center
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        companyView.addSubview(companyLabel)
        
        let companyTextField = UITextField()
        companyTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        companyTextField.textAlignment = .center
        companyTextField.layer.borderWidth = 2
        companyTextField.layer.cornerRadius = 3
        companyTextField.delegate = self
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        companyView.addSubview(companyTextField)
        
        let infoView = UIView()
        infoView.layer.cornerRadius = 20
        infoView.backgroundColor = .white
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.alpha = 0.8
        view.addSubview(infoView)

        let infoLabel = UILabel()
        infoLabel.textColor = .black
        infoLabel.text = "Информация для отображения в таблице"
        infoLabel.numberOfLines = 0
        infoLabel.textAlignment = .center
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(infoLabel)
        
        let nameTextField = UITextField()
        nameTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        nameTextField.textAlignment = .center
        nameTextField.layer.borderWidth = 2
        nameTextField.layer.cornerRadius = 3
        nameTextField.delegate = self
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let surnameTextField = UITextField()
        surnameTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        surnameTextField.textAlignment = .center
        surnameTextField.layer.borderWidth = 2
        surnameTextField.layer.cornerRadius = 3
        surnameTextField.delegate = self
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let dateTextField = UITextField()
        dateTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        dateTextField.textAlignment = .center
        dateTextField.layer.borderWidth = 2
        dateTextField.layer.cornerRadius = 3
        dateTextField.delegate = self
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let emailTextField = UITextField()
        emailTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.textAlignment = .center
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 3
        emailTextField.delegate = self
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let phoneTextField = UITextField()
        phoneTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        phoneTextField.textAlignment = .center
        phoneTextField.layer.borderWidth = 2
        phoneTextField.layer.cornerRadius = 3
        phoneTextField.delegate = self
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let passTextField = UITextField()
        passTextField.layer.borderColor = .init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        passTextField.textAlignment = .center
        passTextField.layer.borderWidth = 2
        passTextField.layer.cornerRadius = 3
        passTextField.delegate = self
        passTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let stackViewInfo = UIStackView(arrangedSubviews: [nameTextField, surnameTextField, dateTextField, emailTextField, phoneTextField, passTextField])
        stackViewInfo.axis = .vertical
        stackViewInfo.distribution = .fillEqually
        stackViewInfo.spacing = 35
        stackViewInfo.alignment = .center
        stackViewInfo.backgroundColor = .black
        stackViewInfo.translatesAutoresizingMaskIntoConstraints = false
        infoView.addSubview(stackViewInfo)
        
        constraints = [
            companyView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            companyView.topAnchor.constraint(equalTo: view.safeArea.topAnchor, constant: 20),
            //            viewCompany.centerYAnchor.constraint(equalTo: view.safeArea.centerYAnchor),
            companyView.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
            companyView.heightAnchor.constraint(equalToConstant: screenHeight / 6.5),
            
            companyTextField.bottomAnchor.constraint(equalTo: companyView.bottomAnchor, constant: -26),
            companyTextField.leadingAnchor.constraint(equalTo: companyView.leadingAnchor, constant: 10),
            companyTextField.trailingAnchor.constraint(equalTo: companyView.trailingAnchor, constant: -10),
            companyTextField.heightAnchor.constraint(equalToConstant: 25),
            
            companyLabel.bottomAnchor.constraint(equalTo: companyTextField.topAnchor, constant: -10),
            companyLabel.leadingAnchor.constraint(equalTo: companyTextField.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: companyTextField.trailingAnchor),
            
            infoView.topAnchor.constraint(equalTo: companyView.bottomAnchor, constant: 10),
            infoView.centerXAnchor.constraint(equalTo: view.safeArea.centerXAnchor),
            infoView.widthAnchor.constraint(equalToConstant: screenWidth / 1.3),
            infoView.bottomAnchor.constraint(equalTo: view.safeArea.bottomAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
            
            stackViewInfo.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 15),
            stackViewInfo.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: 10),
            stackViewInfo.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: -10),
            stackViewInfo.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: -10),
            
            nameTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),
            
            surnameTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            surnameTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),

            dateTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            dateTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),

            emailTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),

            phoneTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),

            passTextField.leadingAnchor.constraint(equalTo: stackViewInfo.leadingAnchor),
            passTextField.trailingAnchor.constraint(equalTo: stackViewInfo.trailingAnchor),

            
        ]
    }
//
//    func standartTextField() -> UITextField {
//        let textField = UITextField()
//        return textField
//    }
    
}

extension SignUp: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
//        var frame = self.viewCompany.frame
//        frame.origin.y = 800
//        UIView.animate(withDuration: 1.3, delay: 0, options: .curveEaseOut, animations: {
//            self.viewCompany.frame = frame
//        }, completion: nil)
    }
    
}
