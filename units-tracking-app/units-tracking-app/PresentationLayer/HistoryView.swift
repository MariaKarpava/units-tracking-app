//
//  HistoryView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct HistoryView: View {

    @EnvironmentObject var drinksService: DrinksService
    

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Text("Edit")
                    .frame(width: 380, height: 90, alignment: .bottomTrailing)
                    .underline()
                Text("History")
                    .frame(width: 380, height: 40, alignment: .leading)
                    .font(.largeTitle)
                ForEach(drinksService.drinksWithUnitsDict.keys.sorted(), id: \.self) { date in
                    let drinksForDate = drinksService.drinksWithUnitsDict[date]!
                    
                    VStack(spacing: 10) { // Adjust spacing as needed
                        ForEach(drinksForDate) { drink in
                            DrinkHistoryRow(drink: drink)
                                .frame(width: 350, height: 80)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 5)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}


struct DrinkHistoryRow: View {
    let drink: DrinkWithUnits
    private var dateFormatterForYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    private var dateFormatterForDayAndMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }
 
 
    var body: some View {
        HStack {
            VStack {
                Text(dateFormatterForDayAndMonth.string(from: drink.date))
                Text(dateFormatterForYear.string(from: drink.date))
            }
            Divider().frame(height: 60)
            VStack(alignment: .leading) {
                Text(drink.drinkType.rawValue.capitalized)
                HStack {
                    Text(String(drink.ml))
                    Text("ml")
                }
            }
            Spacer()
            VStack{
                Text(String(format: "%.1f", drink.units))
                Text("Unit(s)")
            }
        }.frame(width: 330, height: 70)
    }
}


                                                                                     
