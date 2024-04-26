//
//  PreviewSampleData.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Activity.self, MemberGroup.self, User.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: true)
        )
        let modelContext = container.mainContext
        if try modelContext.fetch(FetchDescriptor<Activity>()).isEmpty {
            MockData.activities.forEach { container.mainContext.insert($0) }
        }
        if try modelContext.fetch(FetchDescriptor<MemberGroup>()).isEmpty {
            MockData.simpleMemberGroups.forEach { container.mainContext.insert($0) }
        }
        return container
    } catch {
        fatalError("Failed to create container")
    }
}()
