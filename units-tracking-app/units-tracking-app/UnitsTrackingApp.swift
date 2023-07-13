//
//  units_tracking_appApp.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

@main
struct UnitsTrackingApp: App {
    @StateObject var drinkStore = DrinksStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(drinkStore)
        }
    }
}
