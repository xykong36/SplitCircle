//
//  SplitCircleApp.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData
import SwiftUI

@main
struct SplitCircleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [MemberGroup.self, User.self, ExpenseTransaction.self, Expense.self])
    }
}
