//
//  User.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import Foundation
import SwiftData

@Model
final class User {
    var id: String
    var email: String
    var name: String
    var loginDate: Date?
    
    init(id: String, email: String, name: String, loginDate: Date? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.loginDate = loginDate
    }
}
