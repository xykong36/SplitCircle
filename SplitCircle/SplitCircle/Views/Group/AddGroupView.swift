//
//  AddGroupView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/22/24.
//

import SwiftUI

struct AddGroupView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var groupName: String = ""
    @State private var participantName: String = ""
    @State private var participants: [String] = []

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Group Info")) {
                    TextField("Group Name", text: $groupName)
                }

                Section(header: Text("Participants")) {
                    ForEach(participants, id: \.self) { participant in
                        Text(participant)
                    }
                    .onDelete(perform: deleteParticipant)

                    HStack {
                        TextField("Add Participant", text: $participantName)
                        Button(action: addParticipant) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }

                Section {
                    Button("Save") {
                        saveGroupDetails()
                        dismiss()
                    }
                }
            }
            .navigationBarTitle("Create New Group", displayMode: .inline)
        }
    }

    private func saveGroupDetails() {
        addParticipant()
        let members = participants.map { User(id: UUID().uuidString, name: $0) }
        let newMemberGroup = MemberGroup(id: UUID().uuidString, name: groupName, createdDate: Date.now, members: members, type: "Type A")
        modelContext.insert(newMemberGroup)
        dismiss()
    }

    func addParticipant() {
        if !participantName.isEmpty {
            participants.append(participantName)
            print("Participants now: \(participants)") // Debug print
            participantName = "" // Reset the input field
        }
    }

    func deleteParticipant(at offsets: IndexSet) {
        participants.remove(atOffsets: offsets)
    }
}

#Preview {
    AddGroupView()
}
