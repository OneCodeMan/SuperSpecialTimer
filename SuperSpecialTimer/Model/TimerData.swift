//
//  TimerData.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation

// MARK: timer data
struct TimerData {
    var title: String
    var workDuration: Int // on, seconds
    var currentWorkDuration: Int
    
    var restDuration: Int // off, seconds
    var currentRestDuration: Int
    
    // break
    var breakDuration: Int
    var currentBreakDuration: Int
    
    var numberOfRounds: Int // if infinity, let it go for a while
    var currentRound: Int
    var lastUsed: Date
    
    init() {
        self.title = "Default Title"
        self.workDuration = 4
        self.restDuration = 4
        self.breakDuration = Int.min
        self.numberOfRounds = 5
        self.lastUsed = Date.now
        
        self.currentRound = 1
        self.currentWorkDuration = self.workDuration
        self.currentRestDuration = self.restDuration
        self.currentBreakDuration = self.breakDuration
    }
    
    mutating func reset() {
        self.currentWorkDuration = self.workDuration
        self.currentRestDuration = self.restDuration
        self.currentBreakDuration = self.breakDuration
        self.currentRound = 1
    }
}

// MARK: timer state
enum TimerState: CustomStringConvertible {
    case ready
    case work
    case rest
    case pause // break
    case invalid
    
    var description: String {
        switch self {
        case .ready:
            "ready"
        case .work:
            "work"
        case .rest:
            "rest"
        case .pause:
            "pause"
        case .invalid:
            "invalid"
        }
    }
}
