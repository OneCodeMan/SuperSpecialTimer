//
//  TimerHelper.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-06-05.
//

import Foundation

class TimerHelper {
    
    static func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        let formattedTime = String(format: "%02d:%02d", minutes, remainingSeconds)
        return formattedTime
    }
}
