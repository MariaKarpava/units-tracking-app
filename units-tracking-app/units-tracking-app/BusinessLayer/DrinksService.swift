//
//  DrinksStoreVM.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation


class DrinksService: ObservableObject {
    
    static private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
        
    @Published var drinks = [
        Drink(drinkType: .wine, ml: 150, alcoholByVolume: 125, date: dateFormatter.date(from: "01.05.2023")!),
        Drink(drinkType: .cocktail, ml: 300, alcoholByVolume: 55, date: dateFormatter.date(from: "06.05.2023")!),
        Drink(drinkType: .beer, ml: 200, alcoholByVolume: 60, date: Date()),
        Drink(drinkType: .beer, ml: 500, alcoholByVolume: 55, date: Date())
    ]
    
    
    var drinksWithUnits: [DrinkWithUnits] {
        var result: [DrinkWithUnits] = []
        
        drinks.forEach { drink in
            // units = strength (ABV) x volume (ml) ÷ 1,000
            // here we ÷ 10,000 because we store ABV in Int (we multiplied Double by 10 to convert it into Int)
            let units: Double = Double(drink.ml) * (Double(drink.alcoholByVolume) / 10) / 1000
            
            print(drink.ml)
            print(units)
            print()
            
            let modifiedDrink = DrinkWithUnits(id: drink.id, drinkType: drink.drinkType, date: drink.date, units: units)
            result.append(modifiedDrink)
        }
        
        return result
    }
    
    
    
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
        
        return groupedDrinks
    }
    
    
    var drinksWithUnitsDict: [Date: [DrinkWithUnits]] {
        let calendar = Calendar.current
        var groupedDrinksWithUnits = [Date: [DrinkWithUnits]]()
        
        for drink in drinksWithUnits {
            // Get the date components, excluding the time components
            let dateWithoutTime = calendar.dateComponents([.year, .month, .day], from: drink.date)
            // Create a new date using only the year, month, and day
            let date = calendar.date(from: dateWithoutTime)!
            
            if groupedDrinksWithUnits[date] == nil {
                groupedDrinksWithUnits[date] = [drink]
            } else {
                groupedDrinksWithUnits[date]?.append(drink)
            }
        }
//        print("groupedDrinksWithUnits: \(groupedDrinksWithUnits)")
        return groupedDrinksWithUnits
    }

}



