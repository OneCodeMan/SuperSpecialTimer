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
    @ObservedObject var addEditTimerViewModel = AddEditTimerViewModel()
    var timerData: TimerData
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Group {
                        HStack {
                            Text("Title")
                                .bold()
                                .padding(.trailing)
                            Spacer()
                            TextField(timerData.title, text: $addEditTimerViewModel.title)
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Theme")
                                .bold()
                            Picker("Theme", selection: $addEditTimerViewModel.theme) {
                                ForEach(Theme.allCases, id: \.self) { theme in
                                    Circle()
                                        .fill(theme.mainColor)
                                        .frame(width: 20, height: 20)
                                }
                            }
                            .pickerStyle(.wheel)
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Rounds")
                                .bold()
                                .padding(.trailing)
                            Spacer()
                            TextField(String(timerData.numberOfRounds), value: $addEditTimerViewModel.numberOfRounds, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Work Duration")
                                .bold()
                                .padding(.trailing)
                            Spacer()
                            TextField(String(timerData.workDuration), value: $addEditTimerViewModel.workDuration, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Rest Duration")
                                .bold()
                                .padding(.trailing)
                            Spacer()
                            TextField(String(timerData.restDuration), value: $addEditTimerViewModel.restDuration, formatter: NumberFormatter())
                                .keyboardType(.numberPad)
                        }
                    }
                    // TODO: custom button
                    Button {
                        dismiss()
                        addEditTimerViewModel.submitForm()
                    } label: {
                        Text("Submit")
                    }
                } // section
                
                Section {
                    Group {
                        Button {
                            addEditTimerViewModel.deleteTimer()
                        } label: {
                            Text("Delete Timer")
                        }
                        
                    }
                }
            }
        }
        .onAppear {
            // TODO: terrible
            addEditTimerViewModel.theme = timerData.theme
            addEditTimerViewModel.index = timerData.index
        }
        .navigationTitle("Settings")
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
                Spacer()
            }
            .padding()
        }
    }
}
