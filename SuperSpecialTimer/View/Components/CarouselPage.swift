//
//  Cobain.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-10-31.
//

import SwiftUI

/**
 For the TimerDetailView.
 First page displays the timer in action, second page would be the timer details.
 */
struct CarouselPage: View, Identifiable {
    var id: Int
    @ViewBuilder var content: any View
    
    var body: some View {
        ZStack {
            AnyView(content)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .cornerRadius(20)
        .padding([.horizontal, .bottom], 20)
    }
}
