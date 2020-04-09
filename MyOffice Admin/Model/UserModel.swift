//
//  UserModel.swift
//  MyOffice Admin
//
//  Created by Nikita on 30/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import Foundation

final class Company: NSObject{
    
    // MARK: - Public Properties
    
    var users: [User] = []
    
    // MARK: - Initializers
    
    /// Инициализатор Одиночки всегда должен быть скрытым, чтобы предотвратить
    /// прямое создание объекта через инициализатор.
    private override init() {}
    
    // MARK: - Public Methods
    
    static var shared: Company = {
        let instance = Company()
        /// ... настройка объекта
        /// ...
        return instance
    }()
    
}

extension Company: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
    
}

struct User {
    var info: InfoUser
    var work: WorkUser
    var days: [String] = []
    var coming: [String] = []
    var leaving: [String] = []
}

struct InfoUser {
    var date: String?
    var email: String?
    var name: String?
    var pass: String?
    var phone: String?
    var surname: String?
    var patronymic: String?
}

struct WorkUser: Decodable {
    var admin: Bool?
    var check: Bool?
    var monthHours: Double?
    var weekHours: Double?
    var totalHours: Double?
    var wifi: String?
}
