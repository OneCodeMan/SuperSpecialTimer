//
//  TimerFormPickerView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-07-01.
//

import SwiftUI

// Generic
struct TimerFormPickerView: UIViewRepresentable {
    var data: [[String]] = [
        Array(0...59).map { "\($0)" },
        Array(0...59).map { "\($0)" }
    ]
    
    // bind this to something
    @Binding var selections: [Int]
    
    //makeCoordinator()
    func makeCoordinator() -> TimerFormPickerView.Coordinator {
        Coordinator(self)
    }

    //makeUIView(context:)
    func makeUIView(context: UIViewRepresentableContext<TimerFormPickerView>) -> UIPickerView {
        let picker = UIPickerView(frame: .zero)
        
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator

        return picker
    }

    //updateUIView(_:context:)
    func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<TimerFormPickerView>) {
        for i in 0...(self.selections.count - 1) {
            print("tiemrformpickerview updateuiview-- \(i)")
            view.selectRow(self.selections[i], inComponent: i, animated: false)
        }
        context.coordinator.parent = self // fix
    }
    
    class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        var parent: TimerFormPickerView
        
        //init(_:)
        init(_ pickerView: TimerFormPickerView) {
            self.parent = pickerView
        }
        
        //numberOfComponents(in:)
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return self.parent.data.count
        }
        
        //pickerView(_:numberOfRowsInComponent:)
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return self.parent.data[component].count
        }
        
        //pickerView(_:titleForRow:forComponent:)
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return self.parent.data[component][row]
        }
        
        //pickerView(_:didSelectRow:inComponent:)
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            self.parent.selections[component] = row
        }
    }
}

// MARK: usage demo

struct TimerFormPickerViewDemo: View {
    @State private var selections: [Int] = [0, 0] // which row is initially selected

    var body: some View {
        VStack {
            TimerFormPickerView(selections: self.$selections)
        } //VStack
    }
}

// MARK: Rounds
struct TimerFormRoundsPickerView: View {
    @State private var selections: [Int] = [0]
    private let data: [[String]] = [
        Array(1...30).map { "\($0)" },
    ]

    var body: some View {
        VStack {
            TimerFormPickerView(data: self.data, selections: self.$selections)
        } //VStack
    }
    
}
