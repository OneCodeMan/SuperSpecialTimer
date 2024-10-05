//
//  MockTimers.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation

class MockTimers {
    
    static var mockTimers = [
        TimerData(title: "Baking A Cake", workDuration: 600, restDuration: -1, breakDuration: -1, numberOfRounds: 0),
        TimerData(title: "Pomodoro", workDuration: 600, restDuration: -1, breakDuration: -1, numberOfRounds: 0),
        TimerData(title: "Heavy Bag Workout", workDuration: 180, restDuration: 60, breakDuration: -1, numberOfRounds: 12),
        
        
        // how would this sequence work?
        TimerData(title: "HIIT", workDuration: 20, restDuration: 10, breakDuration: 60, numberOfRounds: 12),
    
    ]
    
    static var initialTimers = [
        TimerData(title: "Pomodoro", workDuration: 1500, restDuration: 300, numberOfRounds: 5, index: 0),
        TimerData(title: "HIIT", workDuration: 20, restDuration: 10, breakDuration: 60, numberOfRounds: 20, index: 1),
        TimerData(title: "Bag Workout", workDuration: 180, restDuration: 60, breakDuration: 60, numberOfRounds: 12, index: 2),
        TimerData(title: "Pomodoro2", workDuration: 1000, restDuration: 300, numberOfRounds: 5, index: 3),
    ]
    
    // input: "5m26s"
    static func timerStringInputParser(timeString ts: String) {
        
    }
    
    // TimerInput(minutes: 5, seconds: 20)
    static func timerInputParser(timeString ts: String) {
        
    }
}

struct TimerInput {
    var minutes: String
    var seconds: String
}

