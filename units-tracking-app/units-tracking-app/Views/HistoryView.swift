//
//  HistoryView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

// TODO: Let's keep codebase clean from unused code. Comments: either delete or uncomment.

// TODO: Table: Would it be better to group rows by date? Sections?
// TODO: Table: What is the plan on wide screens? E.g. iPad in landscape.

struct HistoryView: View {
    @EnvironmentObject var drinksStore: DrinksStore
   
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
//        formatter.timeStyle = .none
        return formatter
    }

    
    var body: some View {
        Form {
            ForEach(drinksStore.drinksDict.keys.sorted(), id: \.self) { date in
                let drinksForDate = drinksStore.drinksDict[date]!

                Section(header: Text(dateFormatter.string(from: date))) {
                    ForEach(drinksForDate, id: \.self) { drink in
                        DrinkHistoryRow(drink: drink)
                    }
                }
            }
        }
    }
}



struct DrinkHistoryRow: View {
    let drink: Drink
 
    var body: some View {
        VStack(alignment: .leading) {
            Text(drink.drinkName.description)
            Text("Volume: \(drink.ml) ml")
            Text("Alcohol Percentage: \(String(format: "%.1f", drink.alcoholByVolume))%")
        }
    }
}


//struct HistoryView_Previews: PreviewProvider {
//    static var previews: some View {
//        let drinksStore = DrinksStore()
//        HistoryView().environmentObject(drinksStore)
//    }
//}

  
                                                                                        
