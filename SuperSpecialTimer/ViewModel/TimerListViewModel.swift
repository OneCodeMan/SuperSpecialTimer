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
        
        fetchTimers()
    }
    
    func fetchTimers() {
        //
        if UserDefaultsHelper.isKeyPresentInUserDefaults(key: "timers") {
            print("we have timers, gonna retrieve them now...")
            if let timerDictsFromUserDefaults = UserDefaults.standard.array(forKey: "timers") as? [[String: String]]  {

                for td in timerDictsFromUserDefaults {
                    let dictToData = TimerData(title: td["title"] ?? "", workDuration: Int(td["work"] ?? "") ?? 0, restDuration: Int(td["rest"] ?? "") ?? 0, numberOfRounds: Int(td["rounds"] ?? "") ?? 0)
                    self.timers.append(dictToData)
                }
            } else {
                // TODO: throw error
                fatalError("failed to retrieve timers.")
            }
        } else {
            self.timers = MockTimers.initialTimers
            
            // TODO: make these initial timers to array of dicts
            let defaults = UserDefaults.standard
            var timersArray: [Dictionary<String, String>] = []

            for td in self.timers {
                let timerDict = ["title": td.title,
                                 "rounds": "\(td.numberOfRounds)",
                                 "work": "\(td.workDuration)",
                                 "rest": "\(td.restDuration)"]
                timersArray.append(timerDict)
            }
            
            // TODO: save that array of timer dicts to userdefaults as "timers"
            defaults.set(timersArray, forKey: "timers")
            
        }
        
        // temporary
        // self.timers = MockTimers.mockTimers
    }
    
}
