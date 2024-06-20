//
//  AddEditTimerViewModel.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-06-11.
//

import Foundation

// timer settings go here?
final class AddEditTimerViewModel: ObservableObject {
    @Published var title = ""
    @Published var numberOfRounds = 0
    @Published var workDuration = 0.0
    @Published var restDuration = 0.0
    
    init() {
        
    }
    
    func submitForm() {
        print("title: \(title)\n rounds: \(numberOfRounds) \n work time: \(workDuration) \n rest time: \(restDuration)")
    }
    
}
