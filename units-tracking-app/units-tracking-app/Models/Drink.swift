//
//  Drink.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation

struct Drink: Hashable, Identifiable {
    let id = UUID()
    
    let drinkType: DrinkType
    let ml: Int
    /// ABV - alcohol by volume - is a standard measure of how much alcohol (ethanol) is contained in a given volume of an alcoholic beverage (expressed as a volume percent).
    /// Int = % * 10
    let alcoholByVolume: Int // TODO: Consider Int. Consider using documentation comments (`/// ...`) to clarify what exactly is stored in this property.
    let date: Date
    
    enum DrinkType {
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
        
        var description: String {
            switch self {
            case .beer:
                return "Beer"
            case .wine:
                return "Wine"
            case .cocktail:
                return "Cocktail"
            case .vodka:
                return "Vodka"
            case .cognac:
                return "Cognac"
            case .whiskey:
                return "Whiskey"
            case .brandy:
                return "Brandy"
            case .champagne:
                return "Champagne"
            case .cider:
                return "Cider"
            case .liqueur:
                return "Liqueur"
            case .shot:
                return "Shot"
            case .tequila:
                return "Tequila"
            case .other:
                return "Other"
            }
        }
    }
    
    init(drinkType: DrinkType, ml: Int, alcoholByVolume: Int, date: Date) {
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
}
