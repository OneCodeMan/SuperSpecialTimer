//
//  TimerData.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation

struct TimerData {
    var title: String
    var workDuration: Int // on, seconds
    var restDuration: Int // off, seconds
    var breakDuration: Int // break
    var numberOfRounds: Int // if infinity, let it go for a while
    var lastUsed: Date
    
    init() {
        self.title = "Default Title"
        self.workDuration = 180
        self.restDuration = 60
        self.breakDuration = Int.min
        self.numberOfRounds = Int.max
        self.lastUsed = Date.now
    }
}
