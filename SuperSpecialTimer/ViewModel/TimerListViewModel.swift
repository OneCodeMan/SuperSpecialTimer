//
//  TimerListViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation

class TimerListViewModel: ObservableObject {
    
    @Published var timers: [TimerData] = []
    
    init(timers: [TimerData] = []) {
        self.timers = timers
        
        fetchTimers()
    }
    
    func fetchTimers() {
        // from user defaults, get the infos.
        self.timers = MockTimers.mockTimers
    }
    
}
