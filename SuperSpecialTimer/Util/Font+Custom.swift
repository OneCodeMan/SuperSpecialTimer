//
//  Font+Custom.swift
//  SuperSpecialTimer
//
//  Created by Dave Gumba on 2024-10-31.
//

import Foundation
import SwiftUI

extension Font {
    
    // Like the timer title for 2nd page of timer detais for example
    static var defaultFontLargeTitle: Font {
        return Font.custom("Tinos-Bold", size: 30.0)
    }
    
    static var defaultFontTitle1: Font {
        return Font.custom("Tinos-Bold", size: 24.0)
    }
    
    static var defaultFontTitle2: Font {
        return Font.custom("Tinos-Bold", size: 22.0)
    }
    
    static var defaultFontTitle3: Font {
        return Font.custom("Tinos-Bold", size: 20.0)
    }
    
    static var defaultFontRegular: Font {
        return Font.custom("Tinos-Regular", size: 16.0)
    }
    
    static var defaultFontRegularStrong: Font {
        return Font.custom("Tinos-Bold", size: 16.0)
    }
    
    static var defaultFontCaption: Font {
        return Font.custom("Tinos-Regular", size: 14.0)
    }
    
}
