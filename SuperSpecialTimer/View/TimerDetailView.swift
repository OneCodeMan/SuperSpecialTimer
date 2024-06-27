//
//  TimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import SwiftUI

struct TimerDetailView: View {
    @StateObject var timerViewModel = TimerViewModel()
    @State var index: Int
    var body: some View {
        NavigationStack {
            Text("")
                .toolbar {
                    // TODO: Coordinator pattern works best man
                    NavigationLink(destination: AddEditTimerView(timerData: timerViewModel.timerData, timerIndex: index)) {
                        Text("Edit")
                    }
                }
            VStack {
                VStack {
                    Text(timerViewModel.timerData.title)
                        .font(.largeTitle)
                    Text("Rounds: \(timerViewModel.timerData.numberOfRounds)")
                    Text("Work (s): \(timerViewModel.timerData.workDuration)")
                    Text("Rest (s): \(timerViewModel.timerData.restDuration)")
                }
                
                Divider()
                
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
        .onAppear {
            self.index = timerViewModel.timerData.index
            print("timerdetailviwr appeared, index is \(self.index)")
            timerViewModel.fetchTimerData(from: index)
        }
    }
}

//#Preview {
//    TimerDetailView()
//}
