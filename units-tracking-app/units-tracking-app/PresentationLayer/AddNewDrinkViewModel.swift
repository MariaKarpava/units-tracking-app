//
//  AddNewDrinkViewModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/07/2023.
//

import Foundation


class AddNewDrinkViewModel: ObservableObject {
    @Published var drinkType: Drink.DrinkType = .wine

    static let volumeRange = Array(stride(from: 5, through: 1000, by: 5))
    @Published var volumeInPicker: Int = volumeRange.first!
    
    static let numberOfDrinksRange = Array(stride(from: 1, through: 50, by: 1))
    @Published var numberOfDrinksInPicker: Int = numberOfDrinksRange.first!

    static let alcoholByVolumeRange = Array(stride(from: 0.1, through: 100.0, by: 0.1))
    @Published var alcoholByVolumeInPicker = alcoholByVolumeRange.first!
    
    let drinksService: DrinksService
    
    init(drinksService: DrinksService) {
        self.drinksService = drinksService
    }
    
    func addNewDrinkTapped() {
        let selectedDrinkType = drinkType
        let enteredVolume = volumeInPicker
        let enteredAlcoholByVolume = Int(alcoholByVolumeInPicker*10)
        let enteredNumberOfDrinks = numberOfDrinksInPicker
        let newDrink = Drink(drinkType: selectedDrinkType, ml: enteredVolume, alcoholByVolume: enteredAlcoholByVolume, date: Date(), numberOfDrinks: enteredNumberOfDrinks)
        drinksService.drinks.append(newDrink)
    }
}
