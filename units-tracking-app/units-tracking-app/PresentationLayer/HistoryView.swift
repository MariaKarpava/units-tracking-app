//
//  HistoryView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct HistoryView: View {
    var body: some View {
        EmptyView()
    }
}


struct DrinkHistoryRow: View {
    let drink: DrinkWithUnits
 
    var body: some View {
        VStack(alignment: .leading) {
            Text(drink.drinkType.rawValue.capitalized)
            Text("Units: \(String(format: "%.1f", drink.units))")
        }
    }
}


                                                                                     
