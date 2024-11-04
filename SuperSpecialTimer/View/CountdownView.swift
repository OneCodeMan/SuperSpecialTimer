//
//  CountdownView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-10-31.
//


/**
 What user sees before timer session starts. Before CircleProgressView.
 */
import SwiftUI

struct CountdownView: View {
//    @EnvironmentObject var runTracker: RunTracker
    @State var timer: Timer?
    @State var countdown = 3
    @State var completion: () -> ()
    
    var originalCountdown = 3
    
    var body: some View {
        Text("\(countdown)")
            .font(.system(size: 256))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
            .onAppear {
                setupCountdown()
            }
            .onDisappear {
                countdown = originalCountdown
            }
    }
    
    func setupCountdown() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if countdown <= 1 {
                timer?.invalidate()
                timer = nil
                completion()
            } else {
                countdown -= 1
            }
        })
    }
}
