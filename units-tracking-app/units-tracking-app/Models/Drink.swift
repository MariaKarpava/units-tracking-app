//
//  NewDrinkModel.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation

// + TODO: move to "units-tracking-app/Model".

// + TODO: why "New"? Does history consist of "New" drinks?L Let's find better name.
struct Drink: Hashable {
    // + TODO: do we need these to be mutable?
    let drinkName: DrinkType
    let ml: Int // + TODO: which units?
    // ABV - alcohol by volume - is a standard measure of how much alcohol (ethanol) is contained in a given volume of an alcoholic beverage (expressed as a volume percent).
    let alcoholByVolume: Double // TODO: naming: consider ABV terminology. Consider Int. Consider using documentation comments (`/// ...`) to clarify what exactly is stored in this property.
    let date: Date // TODO: let's use Date. Format to string when needed to display on UI.
    /// ABV - alcohol by volume - is a standard measure of how much alcohol (ethanol) is contained in a given volume of an alcoholic beverage (expressed as a volume percent).
    /// Int = % * 10
    
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
    
    init(drinkName: DrinkType, ml: Int, alcoholByVolume: Double, date: Date) {
        self.drinkName = drinkName
        self.ml = ml
        self.alcoholByVolume = alcoholByVolume
        self.date = date
    }
}


