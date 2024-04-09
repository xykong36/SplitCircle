//
//  MockData.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/7/24.
//

import Foundation

// Define a simple struct for a MemberGroup
struct SimpleUser {
    var id: String
    var email: String
    var name: String
    var loginDate: Date?
}

// Define a simple struct for a MemberGroup
struct SimpleMemberGroup: Identifiable {
    var id: String
    var name: String
    var members: [SimpleUser]
    var type: String?
}

var activities: [Activity] = [
    Activity(title: "Expense name", date: Date(), groupName: "Group name", amount: 11165.12),
    Activity(title: "English Coursenameeeeeeeeeeeeee", date: Date(), groupName: "Group namededsdadsdsadasdfefraefee", amount: 13.65),
    Activity(title: "BBQ Expense", date: Date(), groupName: "CLT Travel 2024", amount: 15.28),
]

var simpleUser1 = SimpleUser(id: "1", email: "test1@a.com", name: "Alice")
var simpleUser2 = SimpleUser(id: "2", email: "test2@a.com", name: "Bob")
var simpleUser3 = SimpleUser(id: "3", email: "test3@a.com", name: "Charlie")


var simpleMemberGroups: [SimpleMemberGroup] = [
    SimpleMemberGroup(id: "group1", name: "Group 2", members: [simpleUser1],  type: "Type A"),
    SimpleMemberGroup(id: "group2", name: "Group 2", members: [simpleUser1, simpleUser2],  type: "Type B")
]
