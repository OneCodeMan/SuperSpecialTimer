//
//  TimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import SwiftUI

struct TimerDetailView: View {
    @StateObject var timerViewModel = TimerViewModel()
    var body: some View {
        VStack {
            VStack {
                Text("state: \(timerViewModel.timerState.description)")
                Text("round #: \(timerViewModel.timerData.currentRound)")
                Text("duration: \(timerViewModel.display)")
            }
            .padding()
            
            /**
            *  Button group:
                ready --> show play and stop button
                play --> show pause and stop button
                paused --> show play and stop button
                stop --> for now, initial state or nothing.
             */
            HStack {
                
                if timerViewModel.timerState == .ready {

                    TimerDetailButton(iconString: "play.circle") {
                        timerViewModel.onPlay()
                    }
                }
                
                if timerViewModel.timerState == .work || timerViewModel.timerState == .rest {

                    TimerDetailButton(iconString: "pause.circle") {
                        timerViewModel.onPause()
                    }
                }
                
                if timerViewModel.timerState == .pause {
                    TimerDetailButton(iconString: "play.circle") {
                        timerViewModel.onResume()
                    }
                }
                
                TimerDetailButton(iconString: "stop.circle") {
                    // TODO: alert: are you sure?
                    timerViewModel.onStop()
                }
                
            }
            
        }
    }
}

#Preview {
    TimerDetailView()
}
