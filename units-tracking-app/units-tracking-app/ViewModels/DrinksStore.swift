//
//  DrinksStoreVM.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation
import SwiftUI

// + TODO: Keep file name and type name in sync. Here and in all other places.
class DrinksStore: ObservableObject {
    @Published var drinks = [
        Drink(drinkName: .beer, mL: 200, aBV: 6.0, date: "01.07.2023"),
        Drink(drinkName: .beer, mL: 500, aBV: 5.5, date: "02.07.2023"),
        Drink(drinkName: .wine, mL: 150, aBV: 12.5, date: "02.07.2023"),
        Drink(drinkName: .cocktail, mL: 300, aBV: 5.5, date: "03.07.2023"),
        Drink(drinkName: .beer, mL: 500, aBV: 6.0, date: "03.07.2023")
    ]
    
    var drinksDict: [String: [Drink]] {
        Dictionary(grouping: drinks, by: { $0.date })
    }
}
