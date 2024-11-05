//
//  TimerSessionEndView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-11-04.
//

import SwiftUI

// TODO: could this be a modal? quickly save if user confirms. do nothing.
struct TimerSessionEndView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Timer Session End View")
            Button("DISMISSSS") {
                self.dismiss()
            }
        }
    }
}

#Preview {
    TimerSessionEndView()
}
