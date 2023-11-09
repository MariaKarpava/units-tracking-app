//
//  FontStyles.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 06/09/2023.
//

import Foundation
import SwiftUI


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
    static var historyScreenEditButton: Font {
        Font.custom("Inter-Regular", size: 18)
    }
}
