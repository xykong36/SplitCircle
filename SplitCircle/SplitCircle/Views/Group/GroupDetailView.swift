//
//  GroupDetailView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/8/24.
//

import SwiftUI

struct GroupDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    var group: MemberGroup

    var body: some View {
        ScrollView {
            VStack {
                Text(group.name)
                    .font(.title)
                    .padding()

                VStack(alignment: .leading, spacing: 5) {
                    ForEach(group.members, id: \.id) { member in
                        Text(member.name)
                    }
                }
                .padding()

                Button("Delete Group") {
                    deleteGroup()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
            }
            .navigationBarTitle("Group Details", displayMode: .inline)
        }
    }

    private func deleteGroup() {
        modelContext.delete(group)
        dismiss()
    }
}
