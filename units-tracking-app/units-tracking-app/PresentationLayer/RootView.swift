//
//  ContentView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var drinksStore: DrinksStore
    
    
    var body: some View {
        TabView {
            let addNewDrinkVM = AddNewDrinkViewModel(drinksStore: drinksStore)
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
        .environmentObject(drinksStore)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksStore = DrinksStore() 
        RootView().environmentObject(drinksStore)
    }
}
