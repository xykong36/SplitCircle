//
//  Activity.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import Foundation
import SwiftData

@Model
final class Activity {
    var title: String
    var date: Date
    var groupName: String
    var amount: Double

    init(title: String, date: Date, groupName: String, amount: Double) {
        self.title = title
        self.date = date
        self.groupName = groupName
        self.amount = amount
    }
}

extension Activity: Identifiable {}
