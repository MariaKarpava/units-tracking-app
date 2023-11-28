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
    @Published var viewState: ViewState
    
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
        self.viewState = ViewState()
        self.updateViewState()
        
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            object: drinksService,
            queue: .main
        ) { notification in
            // Handle the notification here
            self.viewState.drinkHistoryRowModels = self.convertToDrinkHistoryRowModels()
            print("Received a notification in History View!")
        }
    }
    
    func getDrinksWithUnits() -> [DrinkWithUnits] {
        return drinksService.drinksWithUnits.reversed()
    }
    
    struct ViewState: Equatable {
        enum Content: Equatable {
            case empty
            case notEmpty
        }
        var currentState: Content = .empty
        var drinkHistoryRowModels: [DrinkHistoryRowModel] = []
    }
    
    struct DrinkHistoryRowModel: Equatable, Hashable {
        var drinkWithUnits: DrinkWithUnits
        var shouldDisplayQuantity: Bool {
            drinkWithUnits.numberOfDrinks == 1 ? false : true
        }
    }
    
    func convertToDrinkHistoryRowModels() -> [DrinkHistoryRowModel] {
        var result: [DrinkHistoryRowModel] = []
        getDrinksWithUnits().forEach { drinkWithUnits in
            let drinkHistoryRowModel = DrinkHistoryRowModel(drinkWithUnits: drinkWithUnits)
            result.append(drinkHistoryRowModel)
        }
        return result
    }
    
    func updateViewState() {
        if getDrinksWithUnits().count == 0 {
            viewState.currentState = .empty
        } else {
            viewState.currentState = .notEmpty
            viewState.drinkHistoryRowModels = convertToDrinkHistoryRowModels()
        }
    }
}
