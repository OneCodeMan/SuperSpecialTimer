//
//  TimerData.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation
import SwiftUI

// MARK: timer data
// what we'll display on TimerListView
struct TimerData: Identifiable {
    let id = UUID()
    
    var theme: Theme = Theme.allCases.randomElement() ?? .indigo1
    
    // user related
    var title: String
    var lastUsed: Date
    
    // functionality
    var workDuration: Int
    var currentWorkDuration: Int
    
    var restDuration: Int // off, seconds
    var currentRestDuration: Int
    
    // break
    var breakDuration: Int
    var currentBreakDuration: Int
    
    var numberOfRounds: Int // if infinity, let it go for a while
    var currentRound: Int
    
    // timer's index in array
    var index: Int
    
    init(title: String = "Default Title", theme: Theme = .bubblegum, workDuration: Int, restDuration: Int, breakDuration: Int = -1, numberOfRounds: Int, index: Int = 0) {
        // user defined
        self.title = title
        self.workDuration = workDuration
        self.restDuration = restDuration
        self.breakDuration = breakDuration
        self.numberOfRounds = numberOfRounds
        self.theme = theme
        
        // internal
        self.lastUsed = Date.now
        self.currentRound = 1
        self.currentWorkDuration = self.workDuration
        self.currentRestDuration = self.restDuration
        self.currentBreakDuration = self.breakDuration
        self.index = index
    }
    
    init(title: String = "Default Title", workDuration: Int, restDuration: Int, breakDuration: Int = -1, numberOfRounds: Int, index: Int = 0) {
        // user defined
        self.title = title
        self.workDuration = workDuration
        self.restDuration = restDuration
        self.breakDuration = breakDuration
        self.numberOfRounds = numberOfRounds
        self.theme = Theme.allCases.randomElement() ?? .oxblood
        
        // internal
        self.lastUsed = Date.now
        self.currentRound = 1
        self.currentWorkDuration = self.workDuration
        self.currentRestDuration = self.restDuration
        self.currentBreakDuration = self.breakDuration
        self.index = index
    }
    
    // default init
    init() {
        print("TimerData: default init has been called.")
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
        self.index = 0
    }
    
    mutating func reset() {
        self.currentWorkDuration = self.workDuration
        self.currentRestDuration = self.restDuration
        self.currentBreakDuration = self.breakDuration
        self.currentRound = 1
    }
}

// MARK: timer state
enum TimerState: CustomStringConvertible, Equatable {
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

