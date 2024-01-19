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
        var isToolbarVisible: Bool = false
        
        var editButtonTitle: String = "Edit"
        var selectedDrinksUUIDs: [UUID] = []
        var deleteButtonIsNotActive: Bool = true
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
            viewState.selectedDrinksUUIDs = [] 
        }
    }
    
    func editButtonTapped() {
        if viewState.mode == .edit {
            viewState.isToolbarVisible = true
            viewState.mode = .noEdit
            viewState.editButtonTitle = "Edit"
        } else {
            viewState.isToolbarVisible = false
            viewState.mode = .edit
            viewState.editButtonTitle = "Done"
        }
        
        if viewState.mode == .noEdit {
            viewState.selectedDrinksUUIDs.removeAll()
            updateDeleteButtonState()
//            print("selectedDrinksUUIDs: \(viewState.selectedDrinksUUIDs)")
        }
    }
    
    private func updateDeleteButtonState() {
        if viewState.selectedDrinksUUIDs.count == 0 {
            viewState.deleteButtonIsNotActive = true
            print("delete button is NOT active")
        } else {
            viewState.deleteButtonIsNotActive = false
            print("delete button is active")
        }
        print("selectedDrinksUUIDs: \(viewState.selectedDrinksUUIDs)")
    }
    
    func deleteButtonTapped() {
        drinksService.deleteDrinks(selectedDrinksIDs: viewState.selectedDrinksUUIDs)
        updateViewState() // ?
        updateDeleteButtonState()
    }
    
    func drinkSelected(selectedDrinksID: UUID) {
       viewState.selectedDrinksUUIDs.append(selectedDrinksID)
        updateDeleteButtonState()
    }
    
    func drinkDeselected(deselectedDrinksID: UUID) {
        if let index = viewState.selectedDrinksUUIDs.firstIndex(of: deselectedDrinksID) {
            viewState.selectedDrinksUUIDs.remove(at: index)
            updateDeleteButtonState()
        }
    }
}
