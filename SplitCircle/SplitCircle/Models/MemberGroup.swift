//
//  MemberGroup.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import Foundation
import SwiftData

@Model
final class MemberGroup {
    var id: String
    var name: String
    @Relationship var members: [User]
    var type: String?

    init(id: String, name: String, members: [User], type: String? = nil) {
        self.id = id
        self.name = name
        self.members = members
        self.type = type
    }
}

extension MemberGroup: Identifiable {}
