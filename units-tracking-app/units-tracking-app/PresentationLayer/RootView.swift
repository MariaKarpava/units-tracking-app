//
//  ContentView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

    
struct RootView: View {
    @EnvironmentObject var drinksService: DrinksService
    
    var body: some View {
        TabView {
            let addNewDrinkVM = AddNewDrinkViewModel(drinksService: drinksService)
            AddNewDrinkView(viewModel: addNewDrinkVM)
                .tabItem {
                Label("Add New Drink", systemImage: "plus.circle")
            }

            StatisticsView()
                .tabItem {
                Label("Statistics", systemImage: "waveform")
            }
            HistoryView().tabItem {
                Label("History", systemImage: "book")
            }
            SettingsView().tabItem {
                Label("Settings", systemImage: "person.crop.circle.fill")
            }
        }
        .environmentObject(drinksService)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        RootView().environmentObject(drinksService)
    }
}
