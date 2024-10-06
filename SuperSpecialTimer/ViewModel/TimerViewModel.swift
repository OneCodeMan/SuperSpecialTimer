//
//  TimerViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

/*
 /

 //                       _oo0oo_
 //                      o8888888o
 //                      88" . "88
 //                      (| -_- |)
 //                      0\  =  /0
 //                    ___/`---'\___
 //                  .' \\|     |// '.
 //                 / \\|||  :  |||// \
 //                / _||||| -:- |||||- \
 //               |   | \\\  -  /// |   |
 //               | \_|  ''\---/''  |_/ |
 //               \  .-\__  '-'  ___/-. /
 //             ___'. .'  /--.--\  `. .'___
 //          ."" '<  `.___\_<|>_/___.' >' "".
 //         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 //         \  \ `_.   \_ __\ /__ _/   .-` /  /
 //     =====`-.____`.___ \_____/___.-`___.-'=====
 //                       `=---='
             BUDDHA BLESSES THIS CODE TO BE BUG-FREE!!!!
                         W CODING!!!!
 
 */

/**
 Colour states TimerState???
 uhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh
- salmon pink for break
 - grey for pause
 - green for go
 */

import Foundation
import SwiftUI
import AVFoundation

final class TimerViewModel: ObservableObject {
    @Published var timerData: TimerData = TimerData()
    private var currentTimer: Timer = Timer()
    
    @Published var timerState: TimerState = .ready
    
    // When we resume from a pause,
    // we don't know whether to go to .work or .rest
    // we store that info here.
    private var stateBeforeLastPause: TimerState = .invalid
    @Published var displayStopTimerConfirmation: Bool = false
    
    // What the user sees, parsed numbers
    @Published var display: String = "0:00"
    @Published var workDurationInfo: String = "0:00"
    @Published var restDurationInfo: String = "0:00"
    @Published var roundInfo: String = ""
    @Published var stateColourInfo: Color = .red
    
    func initFromUserDefaults(timerData: TimerData = TimerData()) {
        self.timerData = timerData
    }
    
    // TESTING INIT
    init(timerData: TimerData = TimerData()) {
        print("timer data init() set timerdata and state")
        self.timerData = timerData
        self.timerState = .ready
        
        // set up display
        self.display = TimerHelper.formatTime(seconds: self.timerData.workDuration)
        self.workDurationInfo = TimerHelper.formatTime(seconds: self.timerData.workDuration)
        self.restDurationInfo = TimerHelper.formatTime(seconds: self.timerData.restDuration)
        self.roundInfo = "\(self.timerData.numberOfRounds) Rounds"
        self.stateColourInfo = self.timerData.theme.mainColor
    }
    
    func fetchTimerData(from index: Int) {
        if let timerDictsFromUserDefaults = UserDefaults.standard.array(forKey: "timers") as? [[String: String]] {
            let upAr = timerDictsFromUserDefaults[index]
            let timerThemeString = upAr["theme"] ?? "NIL!!!"
            print("timer theme string: \(timerThemeString)")
            
            let timerTheme = Theme(rawValue: timerThemeString) ?? .orange1
            let updatedTimerData = TimerData(title: upAr["title"] ?? "", theme: timerTheme, workDuration: Int(upAr["work"] ?? "") ?? 0, restDuration: Int(upAr["rest"] ?? "") ?? 0, numberOfRounds: Int(upAr["rounds"] ?? "") ?? 0, index: index)
            self.timerData = updatedTimerData
        }
    }
    
    func onPlay() {
        print("Play button pressed")
        
        // if it's our initial press, set timerState to .work
        if self.timerState == .ready {
            self.playSwitchModeSound()
            self.timerState = .work
            updateDisplayInfo()
        }
        
        // Timer logic
        self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tm in
            
            // WORK ROUND
            if self.timerState == .work {
                self.display = TimerHelper.formatTime(seconds: self.timerData.currentWorkDuration)
                if self.timerData.currentWorkDuration > 0 {
                    self.timerData.currentWorkDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .rest : .invalid
                    self.updateDisplayInfo()
                    self.playSwitchModeSound()
                    
                    // reset duration
                    self.timerData.currentWorkDuration = self.timerData.workDuration
                }
            }
            
            // REST ROUND
            if self.timerState == .rest {
                self.display = TimerHelper.formatTime(seconds: self.timerData.currentRestDuration)
                if self.timerData.currentRestDuration > 0 {
                    self.timerData.currentRestDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .work : .invalid
                    self.updateDisplayInfo()
                    self.timerData.currentRound += 1
                    
                    if self.timerState == .invalid {
                        self.onStop()
                    }

                    // reset duration
                    self.timerData.currentRestDuration = self.timerData.restDuration
                }
            }

        }
    }
    
    func onPause() {
        print("Pause button pressed")
        
        // stop the timer
        self.currentTimer.invalidate()
        
        // save our previous state
        self.stateBeforeLastPause = self.timerState
        
        // show the frozen display of remaining seconds of whatever state we're in.
        // work or rest
        switch self.timerState {
        case .work:
            self.display = TimerHelper.formatTime(seconds: self.timerData.currentWorkDuration)
            self.timerData.currentWorkDuration -= 1
        case .rest:
            self.display = TimerHelper.formatTime(seconds: self.timerData.currentRestDuration)
            self.timerData.currentRestDuration -= 1
        case .pause, .ready, .invalid:
            break
        }
        
        // then change the state to paused
        self.timerState = .pause
        self.updateDisplayInfo()
        
    }
    
    func onResume() {
        print("Resume button pressed")
        
        // If we're not 'paused',
        // this function shouldn't do anything, it shouldn't even be called
        guard self.timerState == .pause else { return }
        
        // go back to the state we were in before the pause.
        self.timerState = self.stateBeforeLastPause
        self.updateDisplayInfo()
        
        // Timer logic
        self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tm in
            
            // WORK ROUND
            if self.timerState == .work {
                self.display = TimerHelper.formatTime(seconds: self.timerData.currentWorkDuration)
                if self.timerData.currentWorkDuration > 0 {
                    self.timerData.currentWorkDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .rest : .invalid
                    self.updateDisplayInfo()
                    
                    // reset duration
                    self.timerData.currentWorkDuration = self.timerData.workDuration
                }
            }
            
            // REST ROUND
            if self.timerState == .rest {
                self.display = TimerHelper.formatTime(seconds: self.timerData.currentRestDuration)
                if self.timerData.currentRestDuration > 0 {
                    self.timerData.currentRestDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .work : .invalid
                    self.updateDisplayInfo()
                    
                    if self.timerState == .invalid {
                        self.onStop()
                    }
                    
                    self.timerData.currentRound += 1
                    
                    // reset duration
                    self.timerData.currentRestDuration = self.timerData.currentRestDuration
                }
            }
        }

    }
    
    func onStop() {
        print("Stop button pressed")
        
        // stop the timer
        self.currentTimer.invalidate()
        
        // reset timer values.
        self.timerData.reset()
        
        // update UI
        self.timerState = .ready
        self.updateDisplayInfo()
        self.display = TimerHelper.formatTime(seconds: self.timerData.workDuration)
    }
    
    func updateDisplayInfo() {
        switch self.timerState {
        case .ready, .invalid:
            self.roundInfo = "\(self.timerData.numberOfRounds) Rounds"
        case .work, .rest, .pause:
            self.roundInfo = "\(self.timerData.currentRound) of \(self.timerData.numberOfRounds) Rounds"
        }
        
        switch self.timerState {
        case .ready:
            self.stateColourInfo = timerData.theme.mainColor
        case .work:
            self.stateColourInfo = .green //todo
        case .rest:
            self.stateColourInfo = .red //todo
        case .pause:
            self.stateColourInfo = .gray //todo
        case .invalid:
            self.stateColourInfo = timerData.theme.mainColor
        }
    }
    
    func playSwitchModeSound() {
        print("playSwitchModeSound() -> Sound should play.")
        // audioPlayerViewModel.playOrPause()
    }
}
