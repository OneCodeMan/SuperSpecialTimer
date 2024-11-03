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
    
    static func formatSeconds(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        
        var parts: [String] = []
        
        if minutes > 0 {
            parts.append("\(minutes) minute\(minutes == 1 ? "" : "s")")
        }
        
        if remainingSeconds > 0 {
            parts.append("\(remainingSeconds) second\(remainingSeconds == 1 ? "" : "s")")
        }
        
        return parts.joined(separator: " ")
    }
}
