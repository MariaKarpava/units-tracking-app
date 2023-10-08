//
//  HistoryViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 05/10/2023.
//

import Foundation
import SwiftUI


class HistoryViewModel: ObservableObject {
    private let drinksService: DrinksService
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
        
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            object: drinksService,
            queue: .main
        ) { notification in
            // Handle the notification here
            print("Received a notification in History View!")
        }
    }
    
    
    func getDatesFromDrinksWithUnits() -> [Date] {
        return drinksService.drinksWithUnitsDict.keys.sorted()
    }
    
    func getDrinksWithUnitsDict() -> [Date: [DrinkWithUnits]] {
        return drinksService.drinksWithUnitsDict
    }
}
