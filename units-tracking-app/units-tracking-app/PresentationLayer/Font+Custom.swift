//
//  FontStyles.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import Foundation
import SwiftUI


// Home Screen
extension Font {
    static var homeScreenUnits: Font {
        Font.custom("Inter-Black", size: 120)
    }
    static var homeScreenText: Font {
        Font.custom("Inter-Black", size: 20)
    }
    static var homeScreenInfoButton: Font {
        Font.custom("Inter-Medium", size: 16)
    }
}
    

// History Screen
extension Font {
    static var historyScreenEditButton: Font {
        Font.custom("Inter-Regular", size: 18)
    }
    static var historyScreenHistoryHeader: Font {
        Font.custom("Inter-SemiBold", size: 32)
    }
    static var historyScreenMainInfo: Font {
        Font.custom("Inter-Medium", size: 16)
    }
    static var historyScreenYear: Font {
        Font.custom("Inter-Medium", size: 12)
    }
    static var historyScreenUnits: Font {
        Font.custom("inter-Black", size: 24)
    }
    static var historyScreenUnitsText: Font {
        Font.custom("Inter-Regular", size: 12)
    }
    static var historyScreenEmpty: Font {
        Font.custom("Inter-Medium", size: 20)
    }
}
