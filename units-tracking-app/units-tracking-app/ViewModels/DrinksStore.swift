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
    
    static private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
//        formatter.timeStyle = .none
        return formatter
    }
    
        
    @Published var drinks = [
        Drink(drinkName: .beer, ml: 200, alcoholByVolume: 6.0, date: Date()),
        Drink(drinkName: .beer, ml: 500, alcoholByVolume: 5.5, date: Date()),
        Drink(drinkName: .wine, ml: 150, alcoholByVolume: 12.5, date: dateFormatter.date(from: "01.02.2023")!),
        Drink(drinkName: .cocktail, ml: 300, alcoholByVolume: 5.5, date: dateFormatter.date(from: "06.05.2023")!),
    ]
    
    
    var drinksDict: [Date: [Drink]] {
        let calendar = Calendar.current
        var groupedDrinks = [Date: [Drink]]()
        
        for drink in drinks {
            // Get the date components, excluding the time components
            let dateWithoutTime = calendar.dateComponents([.year, .month, .day], from: drink.date)
            // Create a new date using only the year, month, and day
            let date = calendar.date(from: dateWithoutTime)!
            
            if groupedDrinks[date] == nil {
                groupedDrinks[date] = [drink]
            } else {
                groupedDrinks[date]?.append(drink)
            }
        }
        
        print(groupedDrinks.keys)
        print()
        return groupedDrinks
    }

}



