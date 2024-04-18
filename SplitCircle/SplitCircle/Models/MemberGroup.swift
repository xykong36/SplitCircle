//
//  MemberGroup.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import Foundation

// Define a simple struct for a MemberGroup
struct MemberGroup: Identifiable {
    var id: String
    var name: String
    var members: [User]
    var type: String?
}
