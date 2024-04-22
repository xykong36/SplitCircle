//
//  GroupsView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/21/24.
//

import SwiftData
import SwiftUI

struct GroupsView: View {
    @Query private var groups: [MemberGroup]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        Button("Delete Group") {
            modelContext.delete(groups[0])
        }
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Button(action: {
                    let newMemberGroup = MemberGroup(id: "group2", name: "Group 2", members: [User(id: "1", name: "Alice"), User(id: "2", name: "Alice2")], type: "Type B")
                    modelContext.insert(newMemberGroup)
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue) // Adjust the plus symbol color as needed
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10)) // Adjust padding to increase vertical size
                        .background(Color.white.opacity(0.5)) // Adjust the background color and opacity to match the image
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                .frame(width: 40, height: 120)
                        )
                }.padding(.leading, 16)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom, spacing: 5) {
                        ForEach(groups) { group in
                            NavigationLink {
                                GroupDetailView(group: group)
                            } label: {
                                GroupItem(group: group)
                            }
                        }
                    }
                }
                .frame(height: 120)
            }
        }
    }
}

struct GroupsTitleView: View {
    var body: some View {
        HStack {
            Text("Groups").font(.title).bold()
            Spacer()
            NavigationLink(destination: AllGroupsView()) {
                Text("View all").foregroundColor(.accentColor)
            }
        }.padding(.horizontal)
    }
}

private struct GroupItem: View {
    var group: MemberGroup

    var body: some View {
        ZStack {
            Image("Green_Group")
                .resizable() // Ensure the image can be resized
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 120)
                .cornerRadius(15)

            VStack(alignment: .leading) {
                Text(group.name)
                    .font(.title3)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .foregroundColor(.white)
                    .padding([.bottom, .trailing], 20.0)
                    .frame(alignment: .topLeading)
                    .frame(width: 100.0, height: 70.0)

                HStack(alignment: .center) {
                    Text("Mar 28")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                    Text("2")
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}

#Preview {
    GroupsView()
}
