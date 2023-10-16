//
//  HistoryView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct HistoryView: View {
    @ObservedObject var HistoryViewModel: HistoryViewModel
    

    var body: some View {
        GeometryReader { bodyGeometry in
            ScrollView(.vertical) {
                VStack(alignment: .center) {
                    Text("Edit")
                        .frame(width: bodyGeometry.size.width - 40, height: 90, alignment: .bottomTrailing)
                        .underline()
                    Text("History")
                        .frame(width: bodyGeometry.size.width - 40, height: 40, alignment: .leading)
                        .font(.largeTitle)
                    ForEach(HistoryViewModel.getDatesFromDrinksWithUnits(), id: \.self) { date in
                        let drinksForDate = HistoryViewModel.getDrinksWithUnitsDict()[date]!
                        
                        VStack(alignment: .center, spacing: 10) {
                            ForEach(drinksForDate) { drink in
                                DrinkHistoryRow(drink: drink)
                                    .frame(width: bodyGeometry.size.width - 40, height: 80)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: Color.primary.opacity(0.1), radius: 5, x: 0, y: 5)
                            }
                        }
                    }
                } // VStack
            
            }.frame(width: bodyGeometry.size.width) // Scroll View

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
        GeometryReader { geometry in
            
            HStack(alignment: .center) {
                VStack {
                    Text(dateFormatterForDayAndMonth.string(from: drink.date))
                    Text(dateFormatterForYear.string(from: drink.date))
                }
                Divider().frame(height: 60)
                VStack(alignment: .leading) {
                    HStack {
                        Text(String(Double(drink.alcoholByVolume) / 10.0))
                        Text("% •")
                        Text(drink.drinkType.rawValue.capitalized)
                    }
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
            }
//            .frame(width: geometry.size.width * 0.9, height: 70)
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let historyViewModel = HistoryViewModel(drinksService: drinksService)
        
        HistoryView(HistoryViewModel: historyViewModel)
            .previewDisplayName("iPhone 14 Pro Max")
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        
        HistoryView(HistoryViewModel: historyViewModel)
            .previewDisplayName("iPhone 14")
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
