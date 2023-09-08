//
//  DrinksStoreVM.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation


class DrinksService: ObservableObject {
    
    var unitsConsumedToday: Double {
        let todaysDrinks = drinksWithUnits.filter { drink in
            let calendar = Calendar.current
            let drinkDateComponents = calendar.dateComponents([.day, .month, .year], from: drink.date)
            let todaysDateComponents = calendar.dateComponents([.day, .month, .year], from: Date())
            
            return drinkDateComponents == todaysDateComponents
        }
        
        let units = todaysDrinks.reduce(0.0) { $0 + $1.units }
        print("unitsConsumedToday: \(units)")
        return units
    }
    
    var unitsConsumedWithinLast7Days: Double {
        let calendar = Calendar.current
        if let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()) {
            let last7DaysDrinks = drinksWithUnits.filter { drink in
                drink.date >= sevenDaysAgo && drink.date <= Date()
            }
            let units = last7DaysDrinks.reduce(0.0) { $0 + $1.units }
            print("unitsConsumedWithinLast7Days: \(units)")
            return units
        } else {
            // Handle the case when sevenDaysAgo is nil
            return 0.0
        }
    }
    
    static private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
        
    @Published var drinks = [
        Drink(drinkType: .wine, ml: 150, alcoholByVolume: 125, date: dateFormatter.date(from: "05.08.2023")!),
        Drink(drinkType: .cocktail, ml: 300, alcoholByVolume: 55, date: dateFormatter.date(from: "06.08.2023")!),
        Drink(drinkType: .beer, ml: 200, alcoholByVolume: 60, date: Date()),
        Drink(drinkType: .beer, ml: 500, alcoholByVolume: 55, date: Date())
    ]
    
    
    var drinksWithUnits: [DrinkWithUnits] {
        var result: [DrinkWithUnits] = []
        
        drinks.forEach { drink in
            // units = strength (ABV) x volume (ml) ÷ 1,000
            // here we ÷ 10,000 because we store ABV in Int (we multiplied Double by 10 to convert it into Int)
            let units: Double = Double(drink.ml) * (Double(drink.alcoholByVolume) / 10) / 1000

            print("Date: \(drink.date), units: \(units)")
            
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



