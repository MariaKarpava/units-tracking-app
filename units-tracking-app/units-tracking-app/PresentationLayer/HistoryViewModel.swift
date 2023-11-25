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
    @Published var drinksWithUnits: [DrinkWithUnits]
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
        drinksWithUnits = drinksService.drinksWithUnits.reversed()
        self.viewState = ViewState()
        self.updateViewState()
        
        NotificationCenter.default.addObserver(
            forName: .drinksHasChanged,
            object: drinksService,
            queue: .main
        ) { notification in
            // Handle the notification here
            self.drinksWithUnits = self.getDrinksWithUnits()
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
    }
    
    func updateViewState() {
        if getDrinksWithUnits().count == 0 {
            viewState.currentState = .empty
        } else {
            viewState.currentState = .notEmpty
        }
    }
}
