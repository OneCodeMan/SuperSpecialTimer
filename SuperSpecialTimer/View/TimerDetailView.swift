//
//  TimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import SwiftUI

struct TimerDetailView: View {
    @ObservedObject var viewModel: TimerViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            ZStack {
                CircleProgressView(
                    progress: viewModel.progress,
                    lineWidth: 6,
                    color: Color(hex: 0xFD8A06)
                )
                .frame(width: 240, height: 240)
                
                Text(viewModel.displayTime)
                    .font(.system(size: 50, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))
                    .contentTransition(.numericText())
                    .monospaced()
            }
            
            HStack {
                if viewModel.shouldShowCancelButton {
                    Button {
                        viewModel.stopAndResetTimer()
                    } label: {
                        Label("Cancel", systemImage: "xmark.circle.fill")
                            .font(.system(size: 70))
                            .symbolRenderingMode(.hierarchical)
                            .labelStyle(.iconOnly)
                            .tint(.red)
                    }
                }
                
                Spacer()
                
                Button {
                    viewModel.toggleTimer()
                } label: {
                    Label(viewModel.isTimerActive ? "Pause" : "Start",
                          systemImage: viewModel.isTimerActive ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 70))
                        .symbolRenderingMode(.hierarchical)
                        .labelStyle(.iconOnly)
                        .tint(viewModel.isTimerActive ? .orange : .green)
                }
            }
            .padding(.vertical, 44)
            .padding(.horizontal, 24)
        }
    }
}

// Usage example
let timerData = TimerData(title: "Sample Timer", workDuration: 60, restDuration: 15, breakDuration: 30, numberOfRounds: 3)
let viewModel = TimerViewModel(timerData: timerData)
let timerDetailView = TimerDetailView(viewModel: viewModel)





//struct TimerDetailView: View {
//    @StateObject var timerViewModel = TimerViewModel()
//    @State var index: Int
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Color(timerViewModel.stateColourInfo)
//                    .opacity(0.3)
//                    .edgesIgnoringSafeArea(.all)
//                
//                // title
//                VStack {
//                    HStack {
//                        Text(timerViewModel.timerData.title)
//                            .font(.largeTitle)
//                            .toolbar {
//                                // TODO: Coordinator pattern works best man
//                                NavigationLink(destination: OldAddEditTimerView(timerData: timerViewModel.timerData)) {
//                                    Text("Edit")
//                                        .disabled(timerViewModel.timerState != .ready)
//                                }
//                            }
//                        Circle()
//                            .fill(timerViewModel.timerData.theme.mainColor)
//                            .frame(width: 20, height: 20)
//                    }
//                    
//                    Text("\(timerViewModel.roundInfo)")
//                        .bold()
//                    
//                    Spacer()
//                    
//                    Text("\(timerViewModel.display)")
//                        .font(.system(size: 100, weight: .heavy, design: .serif))
//                        .padding()
//                    
//                    Spacer()
//                    
//                    HStack {
//                        Text("Work\n\(timerViewModel.workDurationInfo)")
//                        Spacer(minLength: 50.0)
//                        Text("Rest\n\(timerViewModel.restDurationInfo)")
//                    }
//                    .padding(.leading, 14)
//                    .padding(.trailing, 14)
//                
//                    Divider()
//                    
//                    /**
//                     *  Button group:
//                     ready --> show play and stop button
//                     play --> show pause and stop button
//                     paused --> show play and stop button
//                     stop --> for now, initial state or nothing.
//                     */
//                    HStack {
//                        // TODO: could we put this logic in viewmodel?
//                        if timerViewModel.timerState == .ready {
//                            
//                            TimerDetailButton(iconString: "play.circle") {
//                                timerViewModel.onPlay()
//                            }
//                        }
//                        
//                        if timerViewModel.timerState == .work || timerViewModel.timerState == .rest {
//                            
//                            TimerDetailButton(iconString: "pause.circle") {
//                                timerViewModel.onPause()
//                            }
//                        }
//                        
//                        if timerViewModel.timerState == .pause {
//                            TimerDetailButton(iconString: "play.circle") {
//                                timerViewModel.onResume()
//                            }
//                        }
//                        
//                        TimerDetailButton(iconString: "stop.circle") {
//                            timerViewModel.displayStopTimerConfirmation = true
//                            timerViewModel.onPause()
//                        }
//                        .alert("Are you sure you want to stop this current timer session?", isPresented: $timerViewModel.displayStopTimerConfirmation) {
//                            Button("YES") { 
//                                timerViewModel.onStop()
//                            }
//                            
//                            Button("CANCEL") {
//                                timerViewModel.displayStopTimerConfirmation = false
//                            }
//                        }
//                        
//                    }
//                    
//                    Spacer()
//                    
//                }
//                .navigationBarBackButtonHidden(timerViewModel.timerState != .ready)
//                .onAppear {
//                    self.index = timerViewModel.timerData.index
//                    print("timerdetailviwr appeared, index is \(self.index)")
//                    timerViewModel.fetchTimerData(from: index)
//                }
//            }
//        }
//    }
//}
//
////#Preview {
////    TimerDetailView()
////}
