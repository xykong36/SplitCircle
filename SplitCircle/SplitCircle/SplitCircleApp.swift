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
    
    let databasePath = URL.documentsDirectory.appending(path: "database.store")
    
    
    init() {
        let configuration = ModelConfiguration(url: databasePath)
        do {
            customModelContainer = try ModelContainer(
                for: MemberGroup.self, User.self, ExpenseTransaction.self, Expense.self,
                configurations: configuration
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
