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
        fileprivate var selectedDrinksUUIDs: [UUID] = []
        var countOfItemsMarkedToDelete: Int {
            selectedDrinksUUIDs.count
        }
        var deleteButtonIsNotActive: Bool = true
    }
    
    
    struct DrinkHistoryRowModel: Equatable, Hashable {
        var drinkWithUnits: DrinkWithUnits
        var shouldDisplayQuantity: Bool {
            drinkWithUnits.quantity > 1
        }
        var isSelected: Bool
    }
    
    private func rowModels(from drinksWithUnits: [DrinkWithUnits]) -> [DrinkHistoryRowModel] {
        drinksWithUnits.map { DrinkHistoryRowModel(drinkWithUnits: $0, isSelected: viewState.selectedDrinksUUIDs.contains($0.id)) }
    }
    
    private func getDrinksWithUnits() -> [DrinkWithUnits] {
        return drinksService.drinksWithUnits.sorted(by: { $0.date > $1.date })
    }
    
    private func updateViewState() {
        if getDrinksWithUnits().isEmpty {
            viewState.content = .empty
            viewState.mode = .noEdit
            viewState.isToolbarVisible = false
            viewState.editButtonTitle = "Edit"
        } else {
            viewState.content = .notEmpty(drinkHistoryRowModels: rowModels(from: getDrinksWithUnits()))
        }
    }
    
    func editButtonTapped() {
        if viewState.mode == .edit {
            viewState.isToolbarVisible = false
            viewState.mode = .noEdit
            viewState.editButtonTitle = "Edit"
            viewState.selectedDrinksUUIDs = []
            updateDeleteButtonState()
            updateViewState()
        } else {
            viewState.isToolbarVisible = true
            viewState.mode = .edit
            viewState.editButtonTitle = "Done"
        }
    }
    
    private func updateDeleteButtonState() {
        if viewState.selectedDrinksUUIDs.count == 0 {
            viewState.deleteButtonIsNotActive = true
        } else {
            viewState.deleteButtonIsNotActive = false
        }
    }
    
    func deleteButtonTapped() {
        drinksService.deleteDrinks(selectedDrinksIDs: viewState.selectedDrinksUUIDs)
        viewState.selectedDrinksUUIDs = []
        updateViewState()
        updateDeleteButtonState()
        
        if drinksService.drinks.isEmpty {
            viewState.content = .empty
            viewState.isToolbarVisible = false
//            print("Mode:")
//            print(viewState)
//            print("****")
        }
    }
    
    func drinkSelected(selectedDrinksID: UUID) {
       viewState.selectedDrinksUUIDs.append(selectedDrinksID)
        updateDeleteButtonState()
        updateViewState()
    }
    
    func drinkDeselected(deselectedDrinksID: UUID) {
        if let index = viewState.selectedDrinksUUIDs.firstIndex(of: deselectedDrinksID) {
            viewState.selectedDrinksUUIDs.remove(at: index)
            updateDeleteButtonState()
            updateViewState()
        }
    }
}
