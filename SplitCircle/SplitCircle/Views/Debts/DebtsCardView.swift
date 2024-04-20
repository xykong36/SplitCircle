//
//  BillCardView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import SwiftUI

struct DebtsCardView: View {
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .shadow(radius: 10)

            // Content
            VStack(alignment: .leading, spacing: 10) {
                Text("Hi, Nadila Aulia,")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text("you have unpaid bill")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(.white)

                HStack {
                    Text("$156.98")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding()
        }
        .frame(width: 350, height: 150)
        .padding()
    }
}


#Preview {
    DebtsCardView()
}
