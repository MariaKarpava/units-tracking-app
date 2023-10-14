//
//  Drink.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation

struct Drink: Hashable, Identifiable, Codable {
    let id: UUID
    
    var drinkType: DrinkType
    var ml: Int
    /// ABV - alcohol by volume - is a standard measure of how much alcohol (ethanol) is contained in a given volume of an alcoholic beverage (expressed as a volume percent).
    /// Int = % * 10
    var alcoholByVolume: Int
    var date: Date
    
    enum DrinkType: String, CaseIterable, Identifiable, Codable  {
        case beer
        case wine
        case cocktail
        case vodka
        case cognac
        case whiskey
        case brandy
        case champagne
        case cider
        case liqueur
        case shot
        case tequila
        case other
        
        var id: Self { self }
        
    }
    
    init(drinkType: DrinkType, ml: Int, alcoholByVolume: Int, date: Date) {
        self.id = UUID()
        self.drinkType = drinkType
        self.ml = ml
        self.alcoholByVolume = alcoholByVolume
        self.date = date
    }
}




struct DrinkWithUnits: Hashable, Identifiable {
    let id: UUID
    let drinkType: Drink.DrinkType
    let date: Date
    let units: Double
    
    let ml: Int
    var alcoholByVolume: Int
}
