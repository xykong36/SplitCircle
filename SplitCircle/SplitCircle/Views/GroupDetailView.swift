//
//  GroupDetail.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/8/24.
//

import SwiftUI

struct GroupDetailView: View {
    var group: MemberGroup
    
    var body: some View {
        Text(group.name)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GroupDetailView(group: simpleMemberGroups[0])
}
