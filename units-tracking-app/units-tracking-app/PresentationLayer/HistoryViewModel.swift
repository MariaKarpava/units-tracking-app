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
    @Published var drinks: [Drink]
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
        drinks = drinksService.drinks
        
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            object: drinksService,
            queue: .main
        ) { notification in
            // Handle the notification here
            self.drinks = self.getDrinks()
            print("Received a notification in History View!")
        }
    }
    
    func getDrinks() -> [Drink] {
        return drinksService.drinks
    }

    func getDatesFromDrinksWithUnits() -> [Date] {
        return drinksService.drinksWithUnitsDict.keys.sorted(by: >)
    }
    
    func getDrinksWithUnitsDict() -> [Date: [DrinkWithUnits]] {
        return drinksService.drinksWithUnitsDict
    }
}
