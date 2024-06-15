//
//  AllGroupsView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/22/24.
//

import SwiftUI
import SwiftData

struct AllGroupsView: View {
    @Query private var groups: [MemberGroup]
    
    var body: some View {
        NavigationStack {
            List(groups, id: \.id) { group in
                NavigationLink {
                    GroupDetailView(group: group)
                } label: {
                    Text(group.name)
                }
            }
        }
        .navigationBarTitle("All Groups", displayMode: .inline)
    }
}

#Preview {
    AllGroupsView()
}
