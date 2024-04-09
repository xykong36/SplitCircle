//
//  GroupDetail.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/8/24.
//

import SwiftUI

struct GroupDetail: View {
    var group: SimpleMemberGroup
    
    var body: some View {
        Text(group.name)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    GroupDetail(group: simpleMemberGroups[0])
}
