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
            VStack {
                Image(systemName: iconString)
                    .resizable()
                   .scaledToFit()
                   .frame(width: 100, height: 100)
            }
            .clipShape(Circle())
            .frame(width: 125, height: 125)
        }
        .tint(.black)
    }
}

#Preview {
    TimerDetailButton(iconString: "play.circle") {
        print("yo")
    }
}
