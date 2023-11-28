//
//  HistoryView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct ResultView: View {
    var drink: DrinkWithUnits
    var body: some View {
        //  Drink(drinkType: .wine, ml: 150, alcoholByVolume: 125, date: dateFormatter.date(from: "05.09.2023")!),
        VStack {
            Text(String(drink.drinkType.rawValue.capitalized))
        }
    }
}


struct HistoryView: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    

    var body: some View {
        NavigationStack {
            GeometryReader { bodyGeometry in
                ScrollView(.vertical) {
                    LazyVStack(alignment: .center, spacing: 15) {
                        switch historyViewModel.viewState.currentState {
                        case .empty:
                            EmptyDrinkHistory()
                        case .notEmpty:
                            // should use foreach for drinks whenever @Published drinks in VM changes
                            ForEach(historyViewModel.viewState.drinksWithUnits, id: \.self) { drink in
                                NavigationLink(destination: ResultView(drink: drink)) {
                                    DrinkHistoryRow(drink: drink)
                                        .frame(
                                            width: bodyGeometry.size.width - 40,
                                            height: 80
                                        )
                                        .background(Color.white)
                                        .cornerRadius(4)
                                        .shadow(
                                            color: Color.gray.opacity(0.2),
                                            radius: 10,
                                            x: 0,
                                            y: 0
                                        )
                                }
                            }
                        }
                    } // VStack
                    .frame(width: bodyGeometry.size.width)
                }
                .frame(width: historyViewModel.viewState.currentState == .notEmpty ? bodyGeometry.size.width : nil) // Scroll View
                .safeAreaInset(edge: .top, content: { Spacer().frame(height: 20) })
                .padding(.vertical, 20)
//                .border(.red)
            }
            .toolbar { // Geo
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
            .padding(.leading, 20)
        }
    }
}




struct DrinkHistoryRow: View {
    let drink: DrinkWithUnits
    let formatter = DateFormatter()
    
    private var dateFormatterForYear: DateFormatter {
        formatter.dateFormat = "yyyy"
        return formatter
    }
    
    private var dateFormatterForDayAndMonth: DateFormatter {
        formatter.dateFormat = "dd MMM"
        return formatter
    }
    
    
 
 
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .center) {
                    Text(dateFormatterForDayAndMonth.string(from: drink.date))
                        .font(.historyScreenMainInfo)
                        .foregroundColor(.addMainColorForHistoryScreenRaw)
                    Text(dateFormatterForYear.string(from: drink.date))
                        .font(.historyScreenYear)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 98)
                Divider()
                    .frame(height: 60)
                Spacer()
                    .frame(width: 20)

                VStack(alignment: .leading) {
                    HStack {
                        Text(String(format: "%.1f%%", Double(drink.alcoholByVolume) / 10))
                        Text("•")
                        Text(drink.drinkType.rawValue.capitalized)
                    }
                    .frame(height: 32)
                    .font(.historyScreenMainInfo)
                    .foregroundColor(.addMainColorForHistoryScreenRaw)
                       
                    HStack {
                        Text(String(drink.ml)+"ml")
                        Text("•")
                        Text(String(drink.numberOfDrinks))
                    }
                    .font(.historyScreenMainInfo)
                    .foregroundColor(.addMainColorForHistoryScreenRaw)
                    .offset(y: -7)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(format: "%.1f", drink.units))
                        .font(.historyScreenUnits)
                        .foregroundColor(.mainText)
                    Text("unit(s)")
                        .font(.historyScreenUnitsText)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 78)
                Spacer().frame(width: 10)
                
            }
            .frame(width: geometry.size.width, height: 80)
        }
    }
}


struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let historyViewModel = HistoryViewModel(drinksService: drinksService)
        
        HistoryView(historyViewModel: historyViewModel)
            .previewDisplayName("iPhone 14 Pro Max")
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        
        HistoryView(historyViewModel: historyViewModel)
            .previewDisplayName("iPhone 14")
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
