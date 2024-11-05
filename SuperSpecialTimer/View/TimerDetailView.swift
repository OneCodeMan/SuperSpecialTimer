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
    
    // MARK: Logic on which view to display
    @State private var displayCountdownView: Bool = false
    @State private var displayInfoView: Bool = true
    
    // MARK: Alert states
    @State private var displayStopTimerConfirmationAlert: Bool = false
    @State private var displayTimerSessionEndViewModal: Bool = false
    
    // MARK: Environment variables
    @Environment(\.dismiss) var dismiss

    var body: some View {
        // Active state
        if !displayCountdownView && !displayInfoView && !viewModel.isSessionOver() {
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
                            displayStopTimerConfirmationAlert = true
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
                        Label(viewModel.isTimerOnPlay ? "Pause" : "Start",
                              systemImage: viewModel.isTimerOnPlay ? "pause.circle.fill" : "play.circle.fill")
                            .font(.system(size: 70))
                            .symbolRenderingMode(.hierarchical)
                            .labelStyle(.iconOnly)
                            .tint(viewModel.isTimerOnPlay ? .orange : .green)
                    }
                }
                .padding(.vertical, 44)
                .padding(.horizontal, 24)
            }
            .alert(Text("End Session Confirmation"), isPresented: $displayStopTimerConfirmationAlert, actions: {
                Button("Discard Session") {
                    withAnimation {
                        viewModel.stopAndResetTimer()
                    }
                    self.dismiss()
                }
                Button("Terminate Session") {
                    withAnimation {
                        self.displayTimerSessionEndViewModal = true
                    }
                    
                }
                Button("Cancel", role: .cancel) {}
            })
            .navigationBarBackButtonHidden(viewModel.isTimerActive())
            .onAppear {
                viewModel.activateTimer()
            }
            .onDisappear {
                
            }
            .sheet(isPresented: $displayTimerSessionEndViewModal, content: {
                TimerSessionEndView()
                    .onDisappear {
                        self.viewModel.stopAndResetTimer()
                    }
            })
        } else if displayInfoView || viewModel.isSessionOver() {
            TimerInfoView(timerData: $viewModel.timerData) {
                self.displayInfoView = false
                self.displayCountdownView = true
                viewModel.resetPhase()
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
    @Environment(\.dismiss) var dismiss
    @Binding var timerData: TimerData
    @State var dismissAndPresentCountdown: () -> ()
    var body: some View {
        VStack {
            Text(timerData.title)
                .font(.defaultFontLargeTitle)
            Text(timerData.display.numberOfRounds)
            
            // e.g.
            // Work Duration: 30 seconds
            // Work Duration: 5 minutes
            // Work Duration: 5 minutes 30 seconds
            Text(timerData.display.workDuration)
            
            // e.g.
            // Rest Duration: 30 seconds
            // Rest Duration: 5 minutes
            // Rest Duration: 5 minutes 30 seconds
            Text(timerData.display.restDuration)
            
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
