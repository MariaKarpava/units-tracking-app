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
        ) { [ weak self ] notification in
            // Handle the notification here
            guard let strongSelf = self else { return }
            strongSelf.updateViewState()
            print("Received a notification in History View!")
        }
    }
    
    struct ViewState: Equatable {
        enum Content: Equatable {
            case empty
            case notEmpty(drinkHistoryRowModels: [DrinkHistoryRowModel])
        }
        var currentState: Content = .empty
    }
    
    struct DrinkHistoryRowModel: Equatable, Hashable {
        var drinkWithUnits: DrinkWithUnits
        var shouldDisplayQuantity: Bool {
            drinkWithUnits.quantity > 1 ? true : false
        }
    }
    
    private func getDrinksWithUnits() -> [DrinkWithUnits] {
        return drinksService.drinksWithUnits.reversed()
    }
    
    private func convertToDrinkHistoryRowModels() -> [DrinkHistoryRowModel] {
        var result: [DrinkHistoryRowModel] = []
        getDrinksWithUnits().forEach { drinkWithUnits in
            let drinkHistoryRowModel = DrinkHistoryRowModel(drinkWithUnits: drinkWithUnits)
            result.append(drinkHistoryRowModel)
        }
        return result
    }
    
    private func updateViewState() {
        if getDrinksWithUnits().count == 0 {
            viewState.currentState = .empty
        } else {
            viewState.currentState = .notEmpty(drinkHistoryRowModels: convertToDrinkHistoryRowModels())
        }
    }
}
