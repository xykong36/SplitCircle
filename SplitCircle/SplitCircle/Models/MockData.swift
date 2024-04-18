//
//  MockData.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/7/24.
//

import Foundation


var activities: [Activity] = [
    Activity(title: "Expense name", date: Date(), groupName: "Group name", amount: 11165.12),
    Activity(title: "English Coursenameeeeeeeeeeeeee", date: Date(), groupName: "Group namededsdadsdsadasdfefraefee", amount: 13.65),
    Activity(title: "BBQ Expense", date: Date(), groupName: "CLT Travel 2024", amount: 15.28),
]

var simpleUser1 = User(id: "1", email: "test1@a.com", name: "Alice")
var simpleUser2 = User(id: "2", email: "test2@a.com", name: "Bob")
var simpleUser3 = User(id: "3", email: "test3@a.com", name: "Charlie")


var simpleMemberGroups: [MemberGroup] = [
    MemberGroup(id: "group1", name: "Group 2", members: [simpleUser1],  type: "Type A"),
    MemberGroup(id: "group2", name: "Group 2", members: [simpleUser1, simpleUser2],  type: "Type B")
]
