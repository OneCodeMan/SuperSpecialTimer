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
            List {
                ForEach(timerListViewModel.timers) { tm in
                    // Timer List Item View
                    NavigationLink {
                        // FIXME: I don't love how we're making the ViewModel in the view
                        TimerDetailView(timerViewModel: TimerViewModel(timerData: tm), index: tm.index)
                    } label: {
                        TimerListItemView(currentTimer: tm)
                    }
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .background(.clear)
                            .foregroundColor(tm.theme.mainColor)
                            .padding(
                                EdgeInsets(
                                    top: 2,
                                    leading: 10,
                                    bottom: 2,
                                    trailing: 10
                                )
                            )
                    )
                }
                .onDelete { idx in
                    timerListViewModel.timers.remove(atOffsets: idx)
                }
            }
            .navigationTitle("Timers")
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                print("list view appeared")
                timerListViewModel.fetchTimers()
            }
        }
    }
}

// TODO: MOVE THIS TO ITS OWN FILE.
struct TimerListItemView: View {
    let currentTimer: TimerData
    var body: some View {
        VStack {
            Text(currentTimer.title)
                .foregroundColor(currentTimer.theme.accentColor)
                .font(.headline)
                .padding(
                    EdgeInsets(
                        top: 25,
                        leading: 5,
                        bottom: 25,
                        trailing: 5
                    )
                )
        }
        .padding()
    }
}

#Preview {
    TimerListView()
}
