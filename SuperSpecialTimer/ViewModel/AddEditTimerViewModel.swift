//
//  AddEditTimerViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-06-11.
//

import Foundation
import SwiftUI

// timer settings go here?
final class AddEditTimerViewModel: ObservableObject {
    @State var timerData: TimerData = TimerData()
    @Published var title = ""
    @Published var theme: Theme = .bubblegum
    @Published var numberOfRounds = 0
    @Published var workDuration = 0
    @Published var restDuration = 0
    @Published var index: Int = 0
    
    init(timerData td: TimerData = TimerData()) {
        print("AddEdit Timer INIT!!")
    }
    
    func setTimerData(timerData td: TimerData) {
        self.timerData = td
        self.title = td.title
        self.theme = td.theme
        self.numberOfRounds = td.numberOfRounds
        self.workDuration = td.workDuration
        self.restDuration = td.restDuration
    }
    
    func submitForm() {
        print("title: \(title)\n theme: \(theme)\n rounds: \(numberOfRounds) \n work time: \(workDuration) \n rest time: \(restDuration)")
        // take user defaults original timers
        let userDefaults = UserDefaults.standard
        if let sd = userDefaults.array(forKey: "timers") as? [[String: String]] {
            print(sd)
            var userDefaultsTimerDataCopy = sd
            
            let updatedTimerData = TimerData(title: title, theme: theme, workDuration: workDuration, restDuration: restDuration, numberOfRounds: numberOfRounds, index: index)
            
            let updatedTdToDict = ["title": updatedTimerData.title,
                                   "theme": updatedTimerData.theme.name,
                                   "rounds": "\(updatedTimerData.numberOfRounds)",
                                   "work": "\(updatedTimerData.workDuration)",
                                   "rest": "\(updatedTimerData.restDuration)",
                                   "index": "\(updatedTimerData.index)"]
            
            userDefaultsTimerDataCopy[updatedTimerData.index] = updatedTdToDict
            
            userDefaults.set(userDefaultsTimerDataCopy, forKey: "timers")
            
            // DISMISS AND GO BACK TO LIST VIEW
        } else {
            print("submitForm error!!")
        }
        
        
    }
    
    func deleteTimer() {
        
    }
    
    // if default timer
    func resetTimerSettings() {
        
    }
    
}
