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

import Foundation

final class TimerViewModel: ObservableObject {
    @Published var timerData: TimerData = TimerData()
    private var currentTimer: Timer = Timer()
    
    @Published var timerState: TimerState = .ready
    
    // When we resume from a pause,
    // we don't know whether to go to .work or .rest
    // we store that info here.
    private var stateBeforeLastPause: TimerState = .invalid
    
    @Published var display: String = ""
    
    // TODO: for final
    func initFromUserDefaults(timerData: TimerData = TimerData()) {
        // TODO: use info from user defaults to populate TimerData
        self.timerData = timerData
    }
    
    // TODO: for testing//for now
    init(timerData: TimerData = TimerData()) {
        self.timerData = timerData
    }
    
    init() {
        self.timerState = .ready
    }
    
    func onPlay() {
        print("Play button pressed")
        
        // if it's our initial press, set timerState to .work
        if self.timerState == .ready {
            self.timerState = .work
        }
        
        // Timer logic
        self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tm in
            
            // WORK ROUND
            if self.timerState == .work {
                self.display = "\(self.timerData.currentWorkDuration)"
                if self.timerData.currentWorkDuration > 0 {
                    self.timerData.currentWorkDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .rest : .invalid
                    
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
            self.display = "\(self.timerData.currentWorkDuration)"
        case .rest:
            self.display = "\(self.timerData.currentRestDuration)"
        case .pause, .ready, .invalid:
            break
        }
        
        // then change the state to paused
        self.timerState = .pause
        
    }
    
    func onResume() {
        print("Resume button pressed")
        
        // If we're not 'paused',
        // this function shouldn't do anything, it shouldn't even be called
        guard self.timerState == .pause else { return }
        
        // go back to the state we were in before the pause.
        self.timerState = self.stateBeforeLastPause
        
        // Timer logic
        self.currentTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { tm in
            
            // WORK ROUND
            if self.timerState == .work {
                self.display = "\(self.timerData.currentWorkDuration)"
                if self.timerData.currentWorkDuration > 0 {
                    self.timerData.currentWorkDuration -= 1
                } else {
                    self.timerState = self.timerData.currentRound < self.timerData.numberOfRounds ? .rest : .invalid
                    
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
        self.display = "FINISHEDDD"
    }
}
