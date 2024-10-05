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
//        UserDefaults.standard.removeObject(forKey: "timers")
        fetchTimers()
    }
    
    func fetchTimers() {
        self.timers = []
        let defaults = UserDefaults.standard

        if UserDefaultsHelper.isKeyPresentInUserDefaults(key: "timers") {
            print("we have timers, gonna retrieve them now...")
            if let timerDictsFromUserDefaults = defaults.array(forKey: "timers") as? [[String: String]]  {

                var timersUnordered = [TimerData]()
                for td in timerDictsFromUserDefaults {
                    print("dict: \(td)\n")
                    // TODO: CODE SMELL
                    let timerThemeString = td["theme"] ?? "NIL!!!"
                    print("timer theme string: \(timerThemeString)")
                    
                    let timerTheme = Theme(rawValue: timerThemeString) ?? .orange1
                    print("timer theme: \(timerTheme)")
                    
                    let timerIndex = Int(td["index"] ?? "") ?? 0
                    print("timer index: \(timerIndex)")
                    
                    let dictToData = TimerData(title: td["title"] ?? "", theme: timerTheme, workDuration: Int(td["work"] ?? "") ?? 0, restDuration: Int(td["rest"] ?? "") ?? 0, numberOfRounds: Int(td["rounds"] ?? "") ?? 0, index: timerIndex)
                    
                    print(dictToData)
                    timersUnordered.append(dictToData)
                    
                    self.timers = timersUnordered.sorted { $0.index < $1.index }
                    // the indexed version
                    
                    
                    print("FETCHED TIMERS IN THE END: \(self.timers.count) elements\n \(self.timers)")
                    
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
                                 "rest": "\(td.restDuration)",
                                 "index": "\(td.index)"]
                timersArray.append(timerDict)
            }
            
            print("we created timers. \(timersArray)")
            
            // TODO: save that array of timer dicts to userdefaults as "timers"
            defaults.set(timersArray, forKey: "timers")
            
        }
        
        // temporary
        // self.timers = MockTimers.mockTimers
    }
    
    func deleteTimer(at index: IndexSet) {
        self.timers.remove(atOffsets: index)
        print(self.timers)
        
        // convert to dict
        let userDefaults = UserDefaults.standard
        if let sd = userDefaults.array(forKey: "timers") as? [[String: String]] {
            var updatedCopyUserDefaults = sd
            updatedCopyUserDefaults.remove(atOffsets: index)
            
            // Recompute the index property starting from 0
            for (newIndex, _) in updatedCopyUserDefaults.enumerated() {
                updatedCopyUserDefaults[newIndex]["index"] = "\(newIndex)"
            }
            
            userDefaults.set(updatedCopyUserDefaults, forKey: "timers")
        } else {
            print("userdefaults error in timerlistviewmodel::deletetimer -- couldnt get timers array")
        }

        
    }
    
}
