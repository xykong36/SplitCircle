//
//  FilledButtonWithDisable.swift
//  SplitCircle
//
//  Created by Steven Hu on 6/12/24.
//

import SwiftUI

// A custom filled button style
struct FilledButtonWithDisable: ButtonStyle {
    var isEnabled: Bool  // Pass enabled state as a parameter

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(isEnabled ? Color.blue : Color.gray) // Change background color based on enabled state
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .opacity(configuration.isPressed ? 0.5 : 1) // Response to press action
            .opacity(isEnabled ? 1.0 : 0.5) // Change opacity based on enabled state
    }
}
