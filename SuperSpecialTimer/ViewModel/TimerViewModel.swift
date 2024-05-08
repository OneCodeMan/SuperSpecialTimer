//
//  TimerViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation

final class TimerViewModel: ObservableObject {
    @Published var timerData: TimerData = TimerData()
    private var currentTimer: Timer = Timer()
    @Published var timerState: TimerState
    
    @Published var display: String = ""
    
    init() {
        self.timerState = .work
    }
    
    func onPlay() {
        print("Play button pressed")
        
        // Timer logic
        self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tm in
            
            // WORK ROUND
            if self.timerState == .work {
                self.display = "\(self.timerData.currentWorkDuration)"
                if self.timerData.currentWorkDuration > 0 {
                    self.timerData.currentWorkDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .rest : .invalid
                    self.timerData.currentRound += 1
                    
                    // reset duration
                    self.timerData.currentWorkDuration = self.timerData.workDuration
                }
            }
            
            // REST ROUND
            if self.timerState == .rest {
                self.display = "\(self.timerData.currentRestDuration)"
                if self.timerData.currentRestDuration > 0 {
                    self.timerData.currentRestDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .work : .invalid
                    
                    // reset duration
                    self.timerData.currentRestDuration = self.timerData.currentRestDuration
                }
            }

        }
    }
    
    func onPause() {
        print("Pause button pressed")
        self.currentTimer.invalidate()
        
        switch self.timerState {
        case .work:
            self.display = "\(self.timerData.currentWorkDuration)"
        case .rest:
            self.display = "\(self.timerData.currentRestDuration)"
        case .pause:
            self.display = "yeet"
        case .invalid:
            self.display = "yeet"
        }
        
    }
    
    func onResume() {
        print("Resume button pressed")
        self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tm in
            if self.timerData.workDuration > 0 {
                self.timerData.workDuration -= 1
            } else {
                // if number of rounds is > 0, it's rest
                self.timerState = self.timerData.numberOfRounds > 0 ? .rest : .invalid
            }
        }
        
    }
    
    func onStop() {
        print("Stop button pressed")
        self.currentTimer.invalidate()
        self.timerState = .invalid
        
    }
}
