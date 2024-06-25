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
        TimerData(title: "Pomodoro", workDuration: 800, restDuration: 500, numberOfRounds: 5, index: 0),
        TimerData(title: "HIIT", workDuration: 20, restDuration: 10, breakDuration: 60, numberOfRounds: 12, index: 1),
        TimerData(title: "Pomodoro2", workDuration: 900, restDuration: -1, numberOfRounds: 5, index: 2),
    ]
}
