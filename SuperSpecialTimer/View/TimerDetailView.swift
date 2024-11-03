//
//  TimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import SwiftUI

/**
 Consists of a 2 page tab view.
 TabView has 2 CarouselPage instances in it
 - First page is the timer in action
 - Second page is the timer details
 */

// TODO: put `self.displayCountdownView = true` somewhere
struct TimerDetailView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    // MARK: TabView currentIndex change
    @State var currentIndex: Int = 0
    
    @State private var displayCountdownView: Bool = false
    @State private var displayInfoView: Bool = true

    var body: some View {
        // Active state
        if !displayCountdownView && !displayInfoView {
            VStack(spacing: 24) {
                Spacer()
                Text("\(viewModel.timerData.currentRound) / \(viewModel.timerData.numberOfRounds) Rounds")
                
                ZStack {
                    CircleProgressView(
                        progress: viewModel.progress,
                        lineWidth: 6,
                        color: viewModel.timerData.theme.mainColor// Color(hex: 0xFD8A06)
                    )
                    .frame(width: 240, height: 240)
                    
                    Text(viewModel.displayTime)
                        .font(.system(size: 50, weight: .medium))
                        // .foregroundStyle(.white.opacity(0.8))
                        .contentTransition(.numericText())
                        .monospaced()
                }
                Text(viewModel.currentPhaseDisplay)
                    .font(.defaultFontLargeTitle)
                    .padding()
                
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
            .onAppear {
                viewModel.activateTimer()
            }
        } else if displayInfoView {
            TimerInfoView {
                self.displayInfoView = false
                self.displayCountdownView = true
            }
        } else if displayCountdownView {
            CountdownView {
                self.displayCountdownView = false
            }
        }
        
    }
}

struct TimerInfoView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var dismissAndPresentCountdown: () -> ()
    var body: some View {
        VStack {
            Text(viewModel.timerData.title)
                .font(.defaultFontLargeTitle)
            Text(viewModel.timerData.display.numberOfRounds)
            
            // e.g.
            // Work Duration: 30 seconds
            // Work Duration: 5 minutes
            // Work Duration: 5 minutes 30 seconds
            Text(viewModel.timerData.display.workDuration)
            
            // e.g.
            // Rest Duration: 30 seconds
            // Rest Duration: 5 minutes
            // Rest Duration: 5 minutes 30 seconds
            Text(viewModel.timerData.display.restDuration)
            
            Button {
                withAnimation {
                    self.dismissAndPresentCountdown()
                }
            } label: {
                Text("Start!!!")
            }
        }
        .padding()
    }
}

// Usage example
let timerData = TimerData(title: "Sample Timer", workDuration: 60, restDuration: 15, breakDuration: 30, numberOfRounds: 3)
let viewModel = TimerViewModel(timerData: timerData)
let timerDetailView = TimerDetailView(viewModel: viewModel)
