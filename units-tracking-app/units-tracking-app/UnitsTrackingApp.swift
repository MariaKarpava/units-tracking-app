//
//  units_tracking_appApp.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

@main
struct UnitsTrackingApp: App {
    @StateObject var goalsService = GoalsService()
    @StateObject var drinkService = DrinksService()
    

    var body: some Scene {
        WindowGroup {
            RootView(drinksService: drinkService, goalsService: goalsService)
        }
    }
}





