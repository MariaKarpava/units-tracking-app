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
                        switch historyViewModel.viewState.content {
                        case .empty:
                            EmptyDrinkHistory()
                        case .notEmpty(let drinkHistoryRowModels):
                            // should use foreach for drinks whenever @Published drinks in VM changes
                             ScrollView(.vertical) {
                                 LazyVStack(alignment: .center, spacing: 15) {
                                     ForEach(drinkHistoryRowModels, id: \.self) { drinkHistoryRowModel in
                                         HStack {
                                             if historyViewModel.viewState.mode == .edit {
                                                 ChooseButton(isEditing: true)
                                             }
                                             NavigationLink(destination: ResultView(drink: drinkHistoryRowModel.drinkWithUnits)) {
//                                                 HStack {
                                                     DrinkHistoryRow(drink: drinkHistoryRowModel.drinkWithUnits, showQuantity: drinkHistoryRowModel.shouldDisplayQuantity)
                                                         .frame(
    //                                                         width: bodyGeometry.size.width - 40,
                                                            width: historyViewModel.viewState.mode == .edit ? bodyGeometry.size.width - 90 : bodyGeometry.size.width - 40,
                                                             height: 80
                                                         )
//                                                 }
                                                 
                                             }

                                         }
                                    }
                                     .onDelete{ indexSet in
                                         historyViewModel.deleteHistoryRows(at: indexSet)
                                     }
                                 }.frame(width: bodyGeometry.size.width)
                            }
                                .frame(width: historyViewModel.viewState.content == .notEmpty(drinkHistoryRowModels: drinkHistoryRowModels) ? bodyGeometry.size.width : nil) // Scroll View
                                .safeAreaInset(edge: .top, content: { Spacer().frame(height: 20) })
                                .safeAreaInset(edge: .bottom, content: { Spacer().frame(height: RootView.addButtonProtrusion) })
                        }
            }
            .toolbar { // GeometryReader
                ToolbarItem {
                    Button(historyViewModel.viewState.mode == .edit ? "Done" : "Edit") {
                        historyViewModel.editButtonTapped()
                    }
                    .padding()
                }
                ToolbarItem(placement: .topBarLeading) {
                    Text("History")
                        .font(.historyScreenHistoryHeader)
                        .foregroundColor(.accentColor)
                }
                
            }.scrollContentBackground(.hidden)
        }
    }
}


struct EmptyDrinkHistory: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("No data yet")
                .font(.historyScreenEmpty)
                .foregroundColor(.secondaryText)
                .padding(.leading, 20)
                .padding(.top, 30)
        }
    }
}


struct DrinkHistoryRow: View {
    let drink: DrinkWithUnits
    let showQuantity: Bool
    private let formatter = DateFormatter()
    
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
                        .foregroundColor(.mainColorForTextInHistoryScreenRaw)
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
                    .foregroundColor(.mainColorForTextInHistoryScreenRaw)
                       
                    HStack {
                        Text(String(drink.ml)+"ml")
                        if showQuantity {
                            Text("x")
                            Text(String(drink.quantity))
                        }
                    }
                    .font(.historyScreenMainInfo)
                    .foregroundColor(.mainColorForTextInHistoryScreenRaw)
                    .offset(y: -7)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(String(format: "%.1f", drink.units))
                        .font(.historyScreenUnits)
                        .foregroundColor(.accentColor)
                    Text("unit(s)")
                        .font(.historyScreenUnitsText)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 78)
                Spacer().frame(width: 10)
                
            }
            .frame(width: geometry.size.width, height: 80)
        }
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


struct ChooseButton: View {
    let isEditing: Bool
    @State var tapped: Bool = false
    
    var body: some View {
        VStack {
            if isEditing {
                Button(action: {
                    tapped.toggle()
                }) {
                    Circle()
                        .fill(tapped ? Color.orange : Color.green)
//                        .strokeBorder(.gray, lineWidth: 2)
//                        .background(tapped ? Color.orange : Color.white)
                        
                        .frame(width: 25, height: 25)
                }
            }
        }
    }
}




struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let drinksService = DrinksService(goalsService: goalsService)
        let historyViewModel = HistoryViewModel(drinksService: drinksService)
        
        HistoryView(historyViewModel: historyViewModel)
            .previewDisplayName("iPhone 14 Pro Max")
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        
        HistoryView(historyViewModel: historyViewModel)
            .previewDisplayName("iPhone 14")
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
    }
}
