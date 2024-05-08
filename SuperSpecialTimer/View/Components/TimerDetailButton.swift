//
//  TimerDetailButton.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

// "play", "pause", "resume", "stop"
// yadda yadda
// round with thicc gray borders.
// "play.fill", "pause.fill", "stop.fill"

import SwiftUI

struct TimerDetailButton: View {
    let iconString: String
    let action: () -> ()
    @State var isVisible = true // might not need this

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: iconString)
                .padding(5)
                .frame(width: 70, height: 70)
        }
        .tint(.black)
        .buttonBorderShape(.circle)
    }
}

#Preview {
    TimerDetailButton(iconString: "play.circle") {
        print("yo")
    }
}
