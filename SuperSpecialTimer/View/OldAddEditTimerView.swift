//
//  AddEditTimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-06-11.
//

import SwiftUI

// For HIIT timer
// for different types of timer forms, use ViewBuilder?
struct OldAddEditTimerView: View {
    @ObservedObject var addEditTimerViewModel = AddEditTimerViewModel()
    @State var timerData: TimerData
    @State var timerIndex: Int = 0
    
    @State var isOnThemeSelect = false
    @State private var scale: CGFloat = 1.5
    
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
                        VStack {
                            HStack {
                                Text("Theme")
                                    .bold()
                                Picker("Theme", selection: $addEditTimerViewModel.theme) {
                                    ForEach(Theme.allCases, id: \.self) { theme in
                                        Circle()
                                            .fill(theme.mainColor)
                                            .frame(width: 20, height: 20)
                                            .tag(theme)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(height: 120)
                                .onChange(of: addEditTimerViewModel.theme) { oldValue, newValue in
                                    print("old val: \(oldValue), new val: \(newValue)")
                                }
                            }
                            Text(addEditTimerViewModel.theme.name)
                                .foregroundStyle(addEditTimerViewModel.theme.mainColor)
                                .italic()
                                .font(.footnote)
                        }
                    }
                    
                    Group {
                        HStack {
                            Text("Rounds")
                                .bold()
                                .padding(.trailing)
                            Spacer()
                            Picker("", selection: $addEditTimerViewModel.numberOfRounds) {
                                ForEach(1..<100) { rdCount in
                                    Text("\(rdCount)")
                                        .tag(rdCount)
                                }
                            }
                            .pickerStyle(.navigationLink)
                            .frame(height: 80)
//                            TextField(String(timerData.numberOfRounds), value: $addEditTimerViewModel.numberOfRounds, formatter: NumberFormatter())
//                                .keyboardType(.numberPad)
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
            .onAppear {
                // TODO: terrible
                addEditTimerViewModel.setTimerData(timerData: timerData)
                addEditTimerViewModel.index = timerIndex
            }
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
