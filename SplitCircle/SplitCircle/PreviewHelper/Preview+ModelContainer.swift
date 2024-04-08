//
//  Preview+ModelContainer.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/6/24.
//

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Expense.self, Payee.self, MemberGroup.self, User.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            Expense.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
