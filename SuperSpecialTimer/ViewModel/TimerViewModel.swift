//
//  TimerViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation

final class TimerViewModel: ObservableObject {
    var timerData: TimerData?
    // TODO: timer object
    
    func onPlay() {
        print("Play button pressed")
    }
    
    func onPause() {
        print("Pause button pressed")
        
    }
    
    func onResume() {
        print("Resume button pressed")
        
    }
    
    func onStop() {
        print("Stop button pressed")
        
    }
}
