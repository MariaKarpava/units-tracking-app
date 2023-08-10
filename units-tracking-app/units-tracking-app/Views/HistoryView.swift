//
//  HistoryView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var drinksStore: DrinksStore
   
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }

    
//    var body: some View {
//        Form {
//            ForEach(drinksStore.drinksDict.keys.sorted(), id: \.self) { date in
//                let drinksForDate = drinksStore.drinksDict[date]!
//
//                Section(header: Text(dateFormatter.string(from: date))) {
//                    // TODO: check whether id is unique here. consider making Drink to conform to Identifiable.
//                    ForEach(drinksForDate, id: \.self) { drink in
//                        DrinkHistoryRow(drink: drink)
//                    }
//                }
//            }
//        }
//    }
    var body: some View {
        Form {
            ForEach(drinksStore.drinksWithUnitsDict.keys.sorted(), id: \.self) { date in
                let drinksForDate = drinksStore.drinksWithUnitsDict[date]!

                Section(header: Text(dateFormatter.string(from: date))) {
                    // TODO: check whether id is unique here. consider making Drink to conform to Identifiable.
                    ForEach(drinksForDate, id: \.self) { drink in
                        DrinkHistoryRow(drink: drink)
                    }
                }
            }
        }
    }
}



//struct DrinkHistoryRow: View {
//    let drink: Drink
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(drink.drinkType.description)
//            Text("Volume: \(drink.ml) ml")
//            Text("Alcohol Percentage: \(String(format: "%.1f", drink.alcoholByVolume))%")
//        }
//    }
//}

struct DrinkHistoryRow: View {
    let drink: DrinkWithUnits
 
    var body: some View {
        VStack(alignment: .leading) {
            Text(drink.drinkType.rawValue.capitalized)
            Text("Units: \(String(format: "%.1f", drink.units))")
        }
    }
}



struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksStore = DrinksStore()
        HistoryView().environmentObject(drinksStore)
    }
}

  
                                                                                        
