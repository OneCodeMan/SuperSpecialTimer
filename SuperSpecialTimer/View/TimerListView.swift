//
//  TimersView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

/**
 
 TODOs:
 - add "+" form add timer
 */

import SwiftUI

struct TimerListView: View {
    @StateObject var timerListViewModel = TimerListViewModel()
    
    var body: some View {
        NavigationStack {
            List(timerListViewModel.timers) { tm in
                // Timer List Item View
                NavigationLink {
                    // FIXME: I don't love how we're making the ViewModel in the view
                    TimerDetailView(timerViewModel: TimerViewModel(timerData: tm))
                } label: {
                    TimerListItemView(currentTimer: tm)
                }
            }
            .navigationTitle("Timers")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MOVE THIS TO ITS OWN FILE.
struct TimerListItemView: View {
    let currentTimer: TimerData
    var body: some View {
        VStack {
            Text(currentTimer.title)
        }
        .padding()
    }
}

#Preview {
    TimerListView()
}
