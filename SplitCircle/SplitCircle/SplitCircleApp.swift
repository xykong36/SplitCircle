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

    let customModelContainer: ModelContainer
    
    init() {
        do {
            customModelContainer = try ModelContainer(
                for: MemberGroup.self, User.self, ExpenseTransaction.self, Expense.self,
                migrationPlan: SplitCircleMigrationPlan.self
            )
        } catch {
            fatalError("Failed to initialize model container.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(customModelContainer)
    }
}
