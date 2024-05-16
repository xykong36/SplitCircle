//
//  MembersToggleSection.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 5/16/24.
//

import SwiftUI

struct MembersToggleSection: View {
    @Binding var members: [User]
    @Binding var selectedMembers: [User]

    var body: some View {
        ForEach(members, id: \.id) { member in
            Toggle(isOn: Binding(
                get: { selectedMembers.contains { $0.id == member.id } },
                set: { isSelected in
                    if isSelected {
                        selectedMembers.append(member)
                    } else {
                        selectedMembers.removeAll { $0.id == member.id }
                    }
                }
            )) {
                Text(member.name)
            }
            .toggleStyle(CheckboxToggleStyle())
            .padding(.vertical, 2)
        }
    }
}

// Custom ToggleStyle to mimic a checkbox
struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            Button(action: {
                configuration.isOn.toggle()
            }) {
                Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                    .foregroundColor(configuration.isOn ? .blue : .gray)
                    .font(.system(size: 20))
            }
            .buttonStyle(PlainButtonStyle())

            configuration.label
        }
    }
}
