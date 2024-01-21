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
   
    func onDeletionConfirmed() {
        historyViewModel.deleteButtonTapped()
    }
    
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
                                     ForEach(drinkHistoryRowModels, id: \.drinkWithUnits.id) { drinkHistoryRowModel in
                                         if historyViewModel.viewState.isToolbarVisible {
                                                 HStack {
                                                     ChooseButton(historyViewModel: historyViewModel, iDToDelete: drinkHistoryRowModel.drinkWithUnits.id, isSelected: drinkHistoryRowModel.isSelected)
                                                     
                                                     Spacer().frame(width: 17)
                                                     NavigationLink(destination: ResultView(drink: drinkHistoryRowModel.drinkWithUnits)) {
                                                         DrinkHistoryRowInEditingMode(drink: drinkHistoryRowModel.drinkWithUnits, showQuantity: drinkHistoryRowModel.shouldDisplayQuantity)
                                                             .frame(
                                                                width: bodyGeometry.size.width - 90,
                                                                height: 80
                                                             )
                                                         Image(systemName: "chevron.forward")
                                                             .foregroundColor(.mainColorForTextInHistoryScreenRaw)
                                                             
                                                     }
                                                }
                                             } else {
                                             DrinkHistoryRow(drink: drinkHistoryRowModel.drinkWithUnits, showQuantity: drinkHistoryRowModel.shouldDisplayQuantity)
                                                 .frame(
                                                    width: bodyGeometry.size.width - 40,
                                                     height: 80
                                                 )
                                             }
                                    }
                                 }.frame(width: bodyGeometry.size.width)
                            }
                            .frame(width: historyViewModel.viewState.content == .notEmpty(drinkHistoryRowModels: drinkHistoryRowModels) ? bodyGeometry.size.width : nil) // Scroll View
                            .safeAreaInset(edge: .top, content: { Spacer().frame(height: 20) })
                            .safeAreaInset(edge: .bottom, content: { Spacer().frame(height: RootView.addButtonProtrusion) })
                            .toolbar { // GeometryReader
                                ToolbarItem(placement: .topBarTrailing) {
                                    if historyViewModel.viewState.isToolbarVisible {
                                        HStack{
                                            Spacer()
                                            DeleteButton(numberOfDrinksToDelete: historyViewModel.viewState.selectedDrinksUUIDs.count, onDeletionConfirmed: onDeletionConfirmed)
                                                .disabled(historyViewModel.viewState.deleteButtonIsNotActive)
                                                .foregroundColor(historyViewModel.viewState.deleteButtonIsNotActive ? .gray : .red)
                                        }
                                    }
                                }
                            
                                ToolbarItem(placement: .topBarTrailing) {
                                    EditButton(historyViewModel: historyViewModel)
                                }
                                ToolbarItem(placement: .topBarLeading) {
                                    Text("History")
                                        .font(.historyScreenHistoryHeader)
                                        .foregroundColor(.accentColor)
                                }
                        }
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
                // Drink's date
                VStack(alignment: .center) {
                    Text(dateFormatterForDayAndMonth.string(from: drink.date))
                        .font(.historyScreenMainInfo)
                        .foregroundColor(.mainColorForTextInHistoryScreenRaw)
                    Text(dateFormatterForYear.string(from: drink.date))
                        .font(.historyScreenYear)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 98, alignment: .center)
                Divider()
                    .frame(height: 60)
                Spacer()
                    .frame(width: 20)
                // Drink's main info
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
                .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                // Drink's units
                VStack() {
                    Text(String(format: "%.1f", drink.units))
                        .font(.historyScreenUnits)
                        .foregroundColor(.accentColor)
                    Text("unit(s)")
                        .font(.historyScreenUnitsText)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 78, alignment: .trailing)
                Spacer()
                    .frame(width: 10)
                
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


struct DrinkHistoryRowInEditingMode: View {
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
            HStack(alignment:.center, spacing: 0) {
                // Drink's date
                VStack(alignment: .center) {
                    Text(dateFormatterForDayAndMonth.string(from: drink.date))
                        .font(.historyScreenMainInfo)
                        .foregroundColor(.mainColorForTextInHistoryScreenRaw)
                    Text(dateFormatterForYear.string(from: drink.date))
                        .font(.historyScreenYear)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 70, alignment: .center)
                Divider()
                    .frame(height: 60)
                Spacer()
                    .frame(width: 10)
                // Drink's main info
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
                .frame(maxWidth: .infinity, alignment: .leading)
                // Drink's units
                Spacer()
                    .frame(width: 10)
                VStack() {
                    Text(String(format: "%.1f", drink.units))
                        .font(.historyScreenUnits)
                        .foregroundColor(.accentColor)
                    Text("unit(s)")
                        .font(.historyScreenUnitsText)
                        .foregroundColor(.secondaryText)
                }
                .frame(width: 70, alignment: .trailing)
                Spacer()
                    .frame(width: 10)
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
    @ObservedObject var historyViewModel: HistoryViewModel
    let iDToDelete: UUID
    var isSelected: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                if isSelected {
                    historyViewModel.drinkDeselected(deselectedDrinksID: iDToDelete)
                } else {
                    historyViewModel.drinkSelected(selectedDrinksID: iDToDelete)
                }
            }) {
                Circle()
                    .fill(isSelected ? Color.chooseButtonSelected : Color.white)
                                    .overlay(
                                        Circle()
                                            .stroke(isSelected ? Color.chooseButtonSelected: Color.accentColor, lineWidth: 2)
                                    )
                                    .frame(width: 18, height: 18)
            }
        }
    }
}

struct EditButton: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    
    var body: some View {
        Button {
            withAnimation {
                historyViewModel.editButtonTapped()
            }
        } label: {
            Text(historyViewModel.viewState.editButtonTitle)
                .underline()
                .padding()
        }
    }
}

struct DeleteButton: View {
    let numberOfDrinksToDelete: Int
    @State private var confirmationShown = false
    let onDeletionConfirmed: () -> ()
    
    var body: some View {
        Button(action: {
            confirmationShown.toggle()
        }) {
            Text("Delete")
                .underline()
        }
        .confirmationDialog(
            "Would you like to delete \(numberOfDrinksToDelete) item(s)?",
            isPresented: $confirmationShown,
            titleVisibility: .visible
        ) {
            Button("Yes", role: .destructive) {
                withAnimation {
                    onDeletionConfirmed()
                }
            }
            .foregroundColor(.red)
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
