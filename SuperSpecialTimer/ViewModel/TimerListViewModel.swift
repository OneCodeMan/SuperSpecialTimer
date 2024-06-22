//
//  TimerListViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-08.
//

import Foundation
import SwiftUI

class TimerListViewModel: ObservableObject {

    @Published var timers: [TimerData] = []
    
    init(timers: [TimerData] = []) {
        self.timers = timers
        // UserDefaults.standard.removeObject(forKey: "timers")
        fetchTimers()
    }
    
    func fetchTimers() {
        let defaults = UserDefaults.standard

        if UserDefaultsHelper.isKeyPresentInUserDefaults(key: "timers") {
            print("we have timers, gonna retrieve them now...")
            if let timerDictsFromUserDefaults = defaults.array(forKey: "timers") as? [[String: String]]  {

                for td in timerDictsFromUserDefaults {
                    print("dict: \(td)\n")
                    // TODO: CODE SMELL
                    let timerThemeString = td["theme"] ?? "NIL!!!"
                    print("timer theme string: \(timerThemeString)")
                    
                    let timerTheme = Theme(rawValue: timerThemeString) ?? .orange1
                    print("timer theme: \(timerTheme)")
                    
                    let dictToData = TimerData(title: td["title"] ?? "", theme: timerTheme, workDuration: Int(td["work"] ?? "") ?? 0, restDuration: Int(td["rest"] ?? "") ?? 0, numberOfRounds: Int(td["rounds"] ?? "") ?? 0)
                    
                    print(dictToData)
                    self.timers.append(dictToData)
                }
            } else {
                // TODO: throw error
                fatalError("failed to retrieve timers.")
            }
        } else {
            print("No timers, we will create them.")
            self.timers = MockTimers.initialTimers
            
            var timersArray: [Dictionary<String, String>] = []

            for td in self.timers {
                let timerDict = ["title": td.title,
                                 "theme": td.theme.name,
                                 "rounds": "\(td.numberOfRounds)",
                                 "work": "\(td.workDuration)",
                                 "rest": "\(td.restDuration)"]
                timersArray.append(timerDict)
            }
            
            print("we created timers. \(timersArray)")
            
            // TODO: save that array of timer dicts to userdefaults as "timers"
            defaults.set(timersArray, forKey: "timers")
            
        }
        
        // temporary
        // self.timers = MockTimers.mockTimers
    }
    
    func deleteTimer(at index: Int) {
        // TODO: 
    }
    
}
