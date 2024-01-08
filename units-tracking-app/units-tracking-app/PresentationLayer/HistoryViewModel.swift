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
        var content: Content = .empty
        
        enum Mode: Equatable {
            case edit
            case noEdit
        }
        var mode: Mode = .noEdit
        
        var selectedDrinksUUIDs: [UUID] = []
    }
    
    struct DrinkHistoryRowModel: Equatable, Hashable {
        var drinkWithUnits: DrinkWithUnits
        var shouldDisplayQuantity: Bool {
            drinkWithUnits.quantity > 1
        }
    }

    private func getDrinksWithUnits() -> [DrinkWithUnits] {
        drinksService.drinksWithUnits.sorted(by: { $0.date > $1.date })
    }
    
    private func rowModels(from drinksWithUnits: [DrinkWithUnits]) -> [DrinkHistoryRowModel] {
        drinksWithUnits.map { DrinkHistoryRowModel(drinkWithUnits: $0) }
    }
    
    private func updateViewState() {
        if getDrinksWithUnits().isEmpty {
            viewState.content = .empty
        } else {
            viewState.content = .notEmpty(drinkHistoryRowModels: rowModels(from: getDrinksWithUnits()))
        }
    }
    
//    public func deleteHistoryRows(at offsets: IndexSet) {
//        drinksService.deleteDrinks(at: offsets)
//        updateViewState()
//    }
    
    func editButtonTapped() {
        if viewState.mode == .edit {
            viewState.mode = .noEdit
        } else {
            viewState.mode = .edit
        }
        
        if viewState.mode == .noEdit {
            viewState.selectedDrinksUUIDs.removeAll()
            print("Removed all selected drinks")
            print()
        }
    }
    
    func askServiceTODeleteDrinks() {
        drinksService.deleteDrinks(selectedDrinksIDs: viewState.selectedDrinksUUIDs)
        print("Asked services to delete drinks, hopefully they are deleted!")
    }
}
