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
            ZStack {
                Color(timerViewModel.stateColourInfo)
                    .opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                
                // title
                VStack {
                    HStack {
                        Text(timerViewModel.timerData.title)
                            .font(.largeTitle)
                            .toolbar {
                                // TODO: Coordinator pattern works best man
                                NavigationLink(destination: AddEditTimerView(timerData: timerViewModel.timerData, timerIndex: index)) {
                                    Text("Edit")
                                        .disabled(timerViewModel.timerState != .ready)
                                }
                            }
                        Circle()
                            .fill(timerViewModel.timerData.theme.mainColor)
                            .frame(width: 20, height: 20)
                    }
                    
                    Text("\(timerViewModel.roundInfo)")
                        .bold()
                    
                    Spacer()
                    
                    Text("\(timerViewModel.display)")
                        .font(.system(size: 100, weight: .heavy, design: .serif))
                        .padding()
                    
                    Spacer()
                    
                    HStack {
                        Text("Work\n\(timerViewModel.workDurationInfo)")
                        Spacer(minLength: 50.0)
                        Text("Rest\n\(timerViewModel.restDurationInfo)")
                    }
                    .padding(.leading, 14)
                    .padding(.trailing, 14)
                
                    Divider()
                    
                    /**
                     *  Button group:
                     ready --> show play and stop button
                     play --> show pause and stop button
                     paused --> show play and stop button
                     stop --> for now, initial state or nothing.
                     */
                    HStack {
                        // TODO: could we put this logic in viewmodel?
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
                    
                    Spacer()
                    
                }
                .navigationBarBackButtonHidden(timerViewModel.timerState != .ready)
                .onAppear {
                    self.index = timerViewModel.timerData.index
                    print("timerdetailviwr appeared, index is \(self.index)")
                    timerViewModel.fetchTimerData(from: index)
                }
            }
        }
    }
}

//#Preview {
//    TimerDetailView()
//}
