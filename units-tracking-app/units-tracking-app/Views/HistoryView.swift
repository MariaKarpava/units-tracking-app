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

    var body: some View {
        Form {
            ForEach(drinksStore.drinksDict.keys.sorted(), id: \.self) { date in
                Section(header: Text(String(date)).font(.title3)) {
                    ForEach(drinksStore.drinksDict[date]!, id: \.self) { drink in
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
            Text("Volume: \(drink.mL) ml")
            Text("Alcohol Percentage: \(String(format: "%.1f", drink.aBV))%")
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksStore = DrinksStore()
        HistoryView().environmentObject(drinksStore)
    }
}
