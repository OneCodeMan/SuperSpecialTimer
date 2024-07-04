//
//  AddEditTimerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-07-01.
//

import Combine
import SwiftUI

struct AddEditTimerView: View {
    @StateObject var viewModel: AddEditTimerViewModel
    @State var timerIndex: Int = 0
    @Environment(\.dismiss) var dismiss
    
    @State var workMinutes: Int = 0
    @State var workSeconds: Int = 0

    var body: some View {
        NavigationView {
            Form {
                
                // MARK: TIMER TITLE
                Group {
                    HStack {
                        Text("Title")
                            .bold()
                            .padding(.trailing)
                        Spacer()
                        TextField(viewModel.title, text: $viewModel.title)
                        
                    }
                }
                
                // MARK: Number of rounds
                Group {
                    NavigationLink(destination: RoundsPickerView(selectedValue: $viewModel.numberOfRounds, title: "Rounds")) {
                       HStack {
                           Text("Rounds")
                           Spacer()
                           Text("\(viewModel.numberOfRounds)")
                               .foregroundColor(.gray)
                       }
                   }
                }
                
                // MARK: Work duration
                Group {
                    NavigationLink(destination: ActiveTimePickerView(title: "Work Duration", minutes: $workMinutes, seconds: $workSeconds)) {
                        HStack {
                            Text("Work Duration")
                            Spacer()
                            Text("\(viewModel.workDurationDisplay)")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
            }
            .navigationTitle(viewModel.title)
        }
    }
}

struct ActiveTimePickerView: View {
    var title: String
    @Binding var minutes: Int
    @Binding var seconds: Int
    var workDurationInput: Binding<Int> { Binding (
        get: { (minutes * 60) + seconds },
        set: { $0 }
    )
        
    }
    
    var body: some View {
        HStack {
            Picker(selection: $minutes, label: Text("Minutes")) {
                ForEach(0 ..< 60) {
                    Text("\($0)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Text("minutes")
            
            Picker(selection: $seconds, label: Text("Seconds")) {
                ForEach(0 ..< 60) {
                    Text("\($0)")
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Text("seconds")
            
            Spacer()
        }
        .padding()
        .navigationBarTitle(title)
    }
}

struct RoundsPickerView: View {
    @Binding var selectedValue: Int
    var title: String

    var body: some View {
        VStack {
            Text("Selected value: \(selectedValue)")
                .font(.largeTitle)
                .padding()

            Picker(title, selection: $selectedValue) {
                ForEach(0..<10) { value in
                    Text("\(value)").tag(value)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            .clipped()
        }
        .padding()
        .navigationTitle(title)
    }
}
