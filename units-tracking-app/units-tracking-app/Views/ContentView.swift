//
//  ContentView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI

struct ContentView: View {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
