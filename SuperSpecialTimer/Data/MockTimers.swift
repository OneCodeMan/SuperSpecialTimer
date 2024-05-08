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
        TimerData(title: "Heavy Bag Workout", workDuration: 180, restDuration: 60, breakDuration: -1, numberOfRounds: 12),
        
        // how would this sequence work?
        TimerData(title: "HIIT", workDuration: 20, restDuration: 10, breakDuration: 60, numberOfRounds: 12),
    
    ]
}
