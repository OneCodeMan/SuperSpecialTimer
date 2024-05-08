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
            
            HStack {
                Button {
                    timerViewModel.onPause()
                } label: {
                    Text("PAUSE")
                }
                
                Button {
                    timerViewModel.onResume()
                } label: {
                    Text("RESUME")
                }
                
                Button {
                    timerViewModel.onStop()
                } label: {
                    Text("STOP")
                }
            }
            
        }.onAppear {
            timerViewModel.onPlay()
        }
    }
}

#Preview {
    TimerDetailView()
}
