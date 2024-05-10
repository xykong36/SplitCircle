//
//  ActivitiesView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import SwiftData
import SwiftUI

// Custom navigation bar title view with integrated "View all" button
struct ActivitiesTitleView: View {
    var body: some View {
        HStack {
            Text("Activities").font(.title).bold()
            Spacer()
            NavigationLink(destination: ActivitiesView(prefixOnly: false)) {
                Text("View all").foregroundColor(.accentColor)
            }
        }.padding(.horizontal)
    }
}

// Main view that includes the NavigationStack and List
struct ActivitiesView: View {
    @Query private var activities: [Activity]
    @Environment(\.modelContext) private var modelContext
    var prefixOnly: Bool = true
    private let prefixCount = 5 // 定义前缀数量常量
    
    var body: some View {
        
        let displayedActivities = prefixOnly ? Array(activities.prefix(prefixCount)) : activities

        HStack {
            Button("Add Activity") {
                let newActivity = Activity(title: "Activity from Model context", date: Date(), groupName: "Group name", amount: 8885.10)
                modelContext.insert(newActivity)
            }
        }

        List {
            ForEach(displayedActivities) { activity in
                NavigationLink {
                    ActivityDetailView()
                } label: {
                    ActivityRow(activity: activity)
                }
                // TODO: Replace hardcode UI settings
                .frame(height: 45)
                .padding(.vertical, 3)
            }
            .onDelete(perform: deleteActivities)
        }
        // extend the edges to the screen sides
        .listStyle(.plain)
    }
    
    func deleteActivities(_ indexSet: IndexSet) {
        for index in indexSet {
            let activity = activities[index]
            modelContext.delete(activity)
        }
    }
}

#Preview {
    ActivitiesTitleView()
}
