//
//  DebtsCardView.swift
//  SplitCircle
//
//  Created by XIANGYU KONG on 4/17/24.
//

import SwiftUI

struct DebtsCardView: View {
    let customBlue = Color(red: 35 / 255, green: 96 / 255, blue: 250 / 255)
    
    var body: some View {
        ZStack {
            // Background
            RoundedRectangle(cornerRadius: 20)
                .fill(customBlue)
                .shadow(radius: 10)

            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    // Content
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
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 0))

                // Right-side image
                Image("Debts_Card_Image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150) // Adjust the width as needed
            }
        }
        .frame(width: 361, height: 160)
        .padding()
    }
}

#Preview {
    DebtsCardView()
}
