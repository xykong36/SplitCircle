//
//  Group.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import Foundation
import SwiftData

@Model
final class Group {
    @Attribute(.unique) var id: String
    var name: String
    var members: [User]
    var type: String?
    
    init(id: String, members: [User], name: String, type: String? = nil) {
        self.id = id
        self.name = name
        self.members = members
        self.type = type
    }
}
