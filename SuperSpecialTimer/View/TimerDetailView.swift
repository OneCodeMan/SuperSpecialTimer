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
            Text(timerViewModel.timerData.title)
                .font(.largeTitle)
                .toolbar {
                    // TODO: Coordinator pattern works best man
                    NavigationLink(destination: AddEditTimerView(timerData: timerViewModel.timerData, timerIndex: index)) {
                        Text("Edit")
                            .disabled(timerViewModel.timerState != .ready)
                    }
                }
            VStack {
                VStack {
                    Text("\(timerViewModel.timerData.numberOfRounds) Rounds")
                        .bold()
                    Text("\(timerViewModel.display)")
                        .font(.system(size: 100, weight: .heavy, design: .serif))
                    
                    HStack {
                        Text("Work\n\(timerViewModel.workDurationInfo)")
                        Spacer(minLength: 50.0)
                        Text("Rest\n\(timerViewModel.restDurationInfo)")
                    }
                    .padding(.leading, 14)
                    .padding(.trailing, 14)
                }
                
                Divider()
                
                VStack {
                    
                    Text("state: \(timerViewModel.timerState.description)")
                    Text("round #: \(timerViewModel.timerData.currentRound)")
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
