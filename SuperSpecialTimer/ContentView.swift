//
//  ContentView.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-05-06.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    var body: some View {
        if hasCompletedOnboarding {
            TimerListView()
        } else {
            OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
        }
        
    }
}

#Preview {
    ContentView()
}
