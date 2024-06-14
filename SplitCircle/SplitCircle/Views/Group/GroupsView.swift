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
    @Environment(\.colorScheme) var colorScheme
    @State private var showAddGroupView = false

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button(action: {
                    showAddGroupView = true
                }) {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        .frame(width: 40, height: 120)
                        .overlay(
                            Text("+")
                                .font(.system(size: 30))
                                .foregroundColor(colorScheme == .dark ? .white : .blue)
                        )
                }
                    .padding(.leading, 15)
                    .padding(.trailing, 4)
                    .sheet(isPresented: $showAddGroupView) {
                        AddGroupView()
                    }
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
        let backgroundImage = [
            "BackgroundGreen120x104", "BackgroundBlue120x104", "BackgroundCyan120x104",
            "BackgroundOrange120x104", "BackgroundPurple120x104", "BackgroundRed120x104",
            "BackgroundYellow120x104"
        ].randomElement() ?? "BackgroundGreen120x104"
        
        ZStack {
            Image(backgroundImage)
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
                    .padding(.leading, 15)
                    .frame(width: 140.0, height: 70.0, alignment: .topLeading)

                HStack(alignment: .center) {
                    Text(dateFormatter.string(from: group.createdDate))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding([.leading], 15)
                    Spacer()
                    Image(systemName: "person.fill")
                        .foregroundColor(.white)
                    Text(String(group.members.count))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.trailing)
                        .padding(.trailing, 10)
                }
            }
        }
        
    }
}

private var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM.d"
    return formatter
}

#Preview {
    GroupsView()
}
