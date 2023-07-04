//
//  ContentView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var drinksStore: DrinksStore
    
    
    var body: some View {
        TabView {
            AddNewDrinkView()
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

// + TODO: would be nice to leverage previews. Is it possible not not comment this out?
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksStore = DrinksStore() 
        ContentView().environmentObject(drinksStore)
    }
}
