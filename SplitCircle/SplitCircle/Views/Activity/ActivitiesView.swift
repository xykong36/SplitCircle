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
            NavigationLink(destination: AllActivitiesView()) {
                Text("View all").foregroundColor(.accentColor)
            }
        }.padding(.horizontal)
    }
}

// Main view that includes the NavigationStack and List
struct ActivitiesView: View {
    @Query private var activities: [Activity]
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        HStack {
            Button("Add Activity") {
                let newActivity = Activity(title: "Activity from Model context", date: Date(), groupName: "Group name", amount: 8885.10)
                modelContext.insert(newActivity)
            }
    
            Button("Delete Activity") {
                modelContext.delete(activities[0])
            }
        }

        List(activities, id: \.title) { activity in
            NavigationLink {
                ActivityDetailView()
            } label: {
                ActivityRow(activity: activity)
            }
            .frame(height: 45)
            .padding(.vertical, 3)
        }
        .listStyle(.plain)
    }
}

#Preview {
    ActivitiesTitleView()
}
