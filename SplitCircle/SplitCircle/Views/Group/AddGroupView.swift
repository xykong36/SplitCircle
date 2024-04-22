//
//  AddGroupView.swift
//  SplitCircle
//
//  Created by Steven Hu on 4/21/24.
//

import SwiftUI

struct AddGroupView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
                                .foregroundColor(.green)
                        }
                    }
                }
                
                Section {
                    Button("Save") {
                        // Normally handle saving the group details here
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Create New Group", displayMode: .inline)

        }
    }
    
    func addParticipant() {
        if !participantName.isEmpty {
            participants.append(participantName)
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
