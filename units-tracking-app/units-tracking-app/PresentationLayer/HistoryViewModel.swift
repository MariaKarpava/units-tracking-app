//
//  HistoryViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 05/10/2023.
//

import Foundation


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
            drinkWithUnits.quantity > 1
        }
    }
    
    private func getDrinksWithUnits() -> [DrinkWithUnits] {
        let originalDrinksWithUnits = drinksService.drinksWithUnits
        let sortedByDateDrinksWithUnits = originalDrinksWithUnits.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        return sortedByDateDrinksWithUnits
    }
    
    //drinksWithUnitsAsRowModels
    private func rawModels(from drinksWithUnits: [DrinkWithUnits]) -> [DrinkHistoryRowModel] {
        drinksWithUnits.map { DrinkHistoryRowModel(drinkWithUnits: $0) }
    }
    
    private func updateViewState() {
        if getDrinksWithUnits().isEmpty {
            viewState.currentState = .empty
        } else {
            viewState.currentState = .notEmpty(drinkHistoryRowModels: rawModels(from: getDrinksWithUnits()))
        }
    }
}
