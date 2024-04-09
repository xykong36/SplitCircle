//
//  GroupRow.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/8/24.
//

import SwiftUI

struct GroupRow: View {
    var groups: [SimpleMemberGroup]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Groups")
                .font(.title)
                .bold()
                .padding(.leading, 15)
                .padding(.top, 5)

            HStack {
                Button(action: {
                    // Your code to handle the button tap
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
                }.padding(.horizontal, 8)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .bottom, spacing: 5) {
                        ForEach(groups) { group in
                            NavigationLink {
                                GroupDetail(group: group)
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


private struct GroupItem: View {
    var group: SimpleMemberGroup

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                // use can select
                .fill(Color.green)
                .frame(width: 120, height: 120)
            VStack(alignment: .leading) {
                Text(group.name)
                    .font(.headline)
                HStack {
                    Text("Mar 28")
                        .font(.caption)
                    Image(systemName: "person")
                        .foregroundColor(Color.white)
                    Text("2")
                }
            }
        }
    }
}

#Preview {
    GroupRow(groups: simpleMemberGroups)
}
