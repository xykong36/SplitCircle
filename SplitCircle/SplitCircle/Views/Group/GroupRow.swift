//
//  GroupRow.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/8/24.
//

import SwiftUI

struct GroupRow: View {
    var groups: [MemberGroup]

    var body: some View {
        VStack(alignment: .leading) {
            Text("Groups")
                .font(.title)
                .bold()
                .padding(.leading, 15)
                .padding(.top, 5)

            HStack {
                NavigationLink(destination: AddGroupView()) {
                    Image(systemName: "plus")
                        .foregroundColor(.blue)
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                        .background(Color.white.opacity(0.5))
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
                
                HStack(alignment: .center){
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
    GroupRow(groups: simpleMemberGroups)
}
