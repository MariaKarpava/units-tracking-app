//
//  DrinksStoreVM.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import Foundation


class DrinksService {
    let goalsService: GoalsService
            
    static private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }
    
    private let savedDrinksKey = "savedDrinks"
    
    var drinks: [Drink] = [
//        Drink(drinkType: .wine, ml: 150, alcoholByVolume: 125, date: dateFormatter.date(from: "05.08.2023")!, quantity: 1),
//        Drink(drinkType: .cocktail, ml: 300, alcoholByVolume: 55, date: dateFormatter.date(from: "08.09.2023")!, quantity: 3)
    ] {
        didSet{
            NotificationCenter.default.post(name: .drinksHasChanged, object: self)
            //Encode
            let encoder = JSONEncoder()
            do {
                let encodedDrinks = try encoder.encode(drinks)
                UserDefaults.standard.set(encodedDrinks, forKey: savedDrinksKey)
            } catch {
                print("Error encoding array: \(error)")
            }
        }
    }
    
    var drinksWithUnits: [DrinkWithUnits] {
        var result: [DrinkWithUnits] = []
        
        guard !drinks.isEmpty else {
            return result
        }
        
        drinks.forEach { drink in
            // units = strength (ABV) x volume (ml) ÷ 1,000
            // here we ÷ 10,000 because we store ABV in Int (we multiplied Double by 10 to convert it into Int)
            let unitsPerDrink: Double = Double(drink.ml) * (Double(drink.alcoholByVolume) / 10) / 1000
            let totalUnits = unitsPerDrink * Double(drink.quantity)
            
            let modifiedDrink = DrinkWithUnits(
                id: drink.id,
                drinkType: drink.drinkType,
                date: drink.date,
                units: totalUnits,
                quantity: drink.quantity,
                ml: drink.ml,
                alcoholByVolume: drink.alcoholByVolume
            )
            result.append(modifiedDrink)
        }
        return result
    }
    
    init(goalsService: GoalsService) {
        self.goalsService = goalsService
        // Decode
        guard let savedDrinksData = UserDefaults.standard.data(forKey: savedDrinksKey) else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let loadedDrinks = try decoder.decode([Drink].self, from: savedDrinksData)
            drinks = loadedDrinks
        } catch {
            print("Error decoding array: \(error)")
        }
    }
    
    private func unitsConsumedToday() -> Double {
        let todaysDrinks = drinksWithUnits.filter { drink in
            let calendar = Calendar.current
            let drinkDateComponents = calendar.dateComponents([.day, .month, .year], from: drink.date)
            let todaysDateComponents = calendar.dateComponents([.day, .month, .year], from: Date())
            
            return drinkDateComponents == todaysDateComponents
        }

        let units = todaysDrinks.reduce(0.0) { $0 + $1.units }
        return units
    }
    
    private func unitsConsumedWithinLast7Days() -> Double {
        let calendar = Calendar.current
        if let sevenDaysAgo = calendar.date(byAdding: .day, value: -7, to: Date()) {
            let last7DaysDrinks = drinksWithUnits.filter { drink in
                return drink.date >= sevenDaysAgo && drink.date <= Date()
            }
            let units = last7DaysDrinks.reduce(0.0) { $0 + $1.units }
            return units
        } else {
            // Handle the case when sevenDaysAgo is nil
            return 0.0
        }
    }
    
    func unitsRemainingForToday() -> Double {
        var result = 0.0
        let allowedUnitsPerDay = goalsService.unitsPerDay
        let allowedUnitsPer7Days = goalsService.unitsPer7Days
        
        if unitsConsumedWithinLast7Days() > allowedUnitsPer7Days || unitsConsumedToday() > allowedUnitsPerDay {
            result = 0.0
        } else if unitsConsumedWithinLast7Days() < allowedUnitsPer7Days && unitsConsumedToday() > allowedUnitsPerDay {
            result = 0.0
        } else if unitsConsumedWithinLast7Days() < allowedUnitsPer7Days && unitsConsumedToday() < allowedUnitsPerDay {
            let unitsRemainingFor7Days = allowedUnitsPer7Days - unitsConsumedWithinLast7Days()
            let unitsRemainingForTodayIgnoringLast7Days = allowedUnitsPerDay - unitsConsumedToday()
            
            result = min(unitsRemainingFor7Days, unitsRemainingForTodayIgnoringLast7Days)
        }
        return result
    }
    
    func deleteDrinks(selectedDrinksIDs: [UUID]) {
        drinks = drinks.filter { drink in
            !selectedDrinksIDs.contains(drink.id)
        }
    }

}



