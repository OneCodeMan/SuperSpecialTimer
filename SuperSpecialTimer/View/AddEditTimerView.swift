//
//  AddEditTimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-06-11.
//

import SwiftUI

// For HIIT timer
// for different types of timer forms, use ViewBuilder?
struct AddEditTimerView: View {
    var timerData: TimerData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TimerSettingRowView(rowLabel: "Number of Rounds", rowValue: String(timerData.numberOfRounds))
                TimerSettingRowView(rowLabel: "Work Time", rowValue: String(timerData.workDuration))
                TimerSettingRowView(rowLabel: "Rest Time", rowValue: String(timerData.restDuration))
            }
        }
    }
}

struct TimerSettingRowView: View {
    let rowLabel: String
    let rowValue: String
    
    var body: some View {
        NavigationLink(destination: EmptyView()) {
            HStack {
                Spacer()
                Text(rowLabel)
                Spacer()
                Text(rowValue)
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.black)
                Spacer()
            }
            .padding()
            .background(.green)
        }
    }
}
