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
        NavigationView {
            GeometryReader { bodyGeometry in
                ScrollView(.vertical) {
                    VStack(alignment: .center, spacing: 15) {
//                        Text("History")
//                            .frame(width: bodyGeometry.size.width - 40, height: 40, alignment: .leading)
//                            .font(.historyScreenHistoryHeader)
//                            .foregroundColor(.mainText)
//                        Text("Edit")
//                            .frame(width: bodyGeometry.size.width - 40, height: 90, alignment: .bottomTrailing)
//                            .underline()
//                            .foregroundColor(.secondaryText)
//                            .font(.historyScreenEditButton)
                        
                        switch HistoryViewModel.viewState.currentState {
                        case .empty:
                            EmptyDrinkHistory()
                        case .notEmpty:
                            ForEach(HistoryViewModel.getDatesFromDrinksWithUnits(), id: \.self) { date in
                                let drinksForDate = HistoryViewModel.getDrinksWithUnitsDict()[date]!
                                VStack(alignment: .center, spacing: 10) {
                                    ForEach(drinksForDate) { drink in
                                        DrinkHistoryRow(drink: drink)
                                            .frame(width: bodyGeometry.size.width - 40, height: 80)
    //                                        .frame(height: 80)
                                            .background(Color.white)
                                            .cornerRadius(4)
                                            .shadow(color: Color.gray.opacity(0.2), radius: 6, x: 0, y: 0)
                                    }
                                }
                            }
    //                        .frame(width: bodyGeometry.size.width - 20) // ForEach
                        }
                    } // VStack
                }
                .frame(width: bodyGeometry.size.width) // Scroll View
                .padding(.vertical, 20)
            }.toolbar { // Geo
                ToolbarItem(placement: .topBarLeading) {
                    Text("History")
                        .font(.historyScreenHistoryHeader)
                        .foregroundColor(.mainText)
                }
            }
        }
    }
}



struct EmptyDrinkHistory: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("No data yet")
            .font(.historyScreenEmpty)
            .foregroundColor(.secondaryText)
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
                VStack(alignment: .center) {
                    Text(dateFormatterForDayAndMonth.string(from: drink.date))
                        .font(.historyScreenMainInfo)
                        .foregroundColor(.addMainHistoryScreenColor)
                    Text(dateFormatterForYear.string(from: drink.date))
                        .font(.historyScreenYear)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 98)
                Divider()
                    .frame(height: 60)
//                    .offset(x: -8)
                    .padding(.horizontal, 8)

                VStack(alignment: .leading) {
                    HStack {
                        Text(String(format: "%.1f%%", Double(drink.alcoholByVolume) / 10))
                        Text(" • ")
                        Text(drink.drinkType.rawValue.capitalized)
                    }
                    .frame(height: 32)
                    .font(.historyScreenMainInfo)
                    .foregroundColor(.addMainHistoryScreenColor)
                       
                    Text(String(drink.ml)+"ml")
                    .font(.historyScreenMainInfo)
                    .foregroundColor(.addMainHistoryScreenColor)
                    .offset(y: -7)
                }
                Spacer()
                VStack(alignment: .center) {
                    Text(String(format: "%.1f", drink.units))
                        .font(.historyScreenUnits)
                        .foregroundColor(.mainText)
                    Text("Unit(s)")
                        .font(.historyScreenUnitsText)
                        .foregroundColor(.secondaryText)
                }.frame(width: 78)
                
            }
            .frame(width: geometry.size.width, height: 80)
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
