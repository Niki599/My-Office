//
//  UserModel.swift
//  MyOffice Admin
//
//  Created by Nikita on 30/12/2019.
//  Copyright © 2019 Андрей Гаврилов. All rights reserved.
//

import Foundation

struct Company {
    var users: [User?]
//    init() {
//
//    }
}

struct User{
    var user: Stat?
//    init(date: String, email: String, name: String, pass: String, phone: String, surname: String, admin: Bool, check: Bool, coming: String, leaving: String, monthHours: Int, weekHours: Int, totalHours: Int) {
//        user!.info!.date = date
//        user!.info!.email = email
//        user!.info!.name = name
//        user!.info!.pass = pass
//        user!.info!.phone = phone
//        user!.info!.surname = surname
//        user!.work!.admin = admin
//        user!.work!.check = check
//        user!.work!.coming = coming
//        user!.work!.leaving = leaving
//        user!.work!.monthHours = monthHours
//        user!.work!.weekHours = weekHours
//        user!.work!.totalHours = totalHours
//    }
//    init() {
//
//    }
}

struct Stat {
    var info: InfoUser?
    var work: WorkUser?
//    init(date: String, email: String, name: String, pass: String, phone: String, surname: String, admin: Bool, check: Bool, coming: String, leaving: String, monthHours: Int, weekHours: Int, totalHours: Int) {
//        info!.date = date
//        info!.email = email
//        info!.name = name
//        info!.pass = pass
//        info!.phone = phone
//        info!.surname = surname
//        work!.admin = admin
//        work!.check = check
//        work!.coming = coming
//        work!.leaving = leaving
//        work!.monthHours = monthHours
//        work!.weekHours = weekHours
//        work!.totalHours = totalHours
//    }
//    init() {
//
//    }
}

struct InfoUser {
    var date: String
    var email: String
    var name: String
    var pass: String
    var phone: String
    var surname: String
//    init() {
//
//    }
//    init(date: String, email: String, name: String, pass: String, phone: String, surname: String) {
//        self.date = date
//        self.email = email
//        self.name = name
//        self.pass = pass
//        self.phone = phone
//        self.surname = surname
//    }
}

struct WorkUser: Decodable {
    var admin: Bool
    var check: Bool
    var coming: String
    var leaving: String
    var monthHours: Int
    var weekHours: Int
    var totalHours: Int
//    init() {
//
//    }
//    init(admin: Bool, check: Bool, coming: String, leaving: String, monthHours: Int, weekHours: Int, totalHours: Int) {
//        self.admin = admin
//        self.check = check
//        self.coming = coming
//        self.leaving = leaving
//        self.monthHours = monthHours
//        self.weekHours = weekHours
//        self.totalHours = totalHours
//    }
    
}
