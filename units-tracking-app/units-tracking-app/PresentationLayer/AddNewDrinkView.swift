//
//  AddNewDrinkView.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 03/07/2023.
//

import SwiftUI


struct AddNewDrinkView: View {
    @StateObject private var viewModel: AddNewDrinkViewModel
    
    private var addNewDrinkButton: some View {
        Button {
            viewModel.addNewDrinkTapped()
        } label : {
            Text("Add New Drink")
        }.buttonStyle(.bordered)
    }
    
    init(viewModel: AddNewDrinkViewModel) {
        // use _ to set raw value to wrapped properties
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack{
            Form{
                drinkTypeSection
                drinkVolumeSection
                abvSection
                drinkNumberSection
            }
            .navigationTitle("Add New Drink")
            addNewDrinkButton
        }
    }
                    
    private var drinkTypeSection: some View {
        Section(header: Text("Drink Type")) {
            Picker("Drink Type", selection: $viewModel.drinkType) {
                ForEach(Drink.DrinkType.allCases) { drinkType in
                    Text(drinkType.rawValue.capitalized)
                }
                .pickerStyle(.wheel)
            }
        }
    }
    
    private var drinkVolumeSection: some View {
        Section(header: Text("Drink Volume")) {
            Picker("Please add volume in ml", selection: $viewModel.volumeInPicker) {
                ForEach(AddNewDrinkViewModel.volumeRange, id: \.self) { volume in
                   Text("\(volume)")
                }
            }
        }
    }
    
    private var drinkNumberSection: some View {
        Section(header: Text("Drink Number")) {
            Picker("Please add number of drinks", selection: $viewModel.numberOfDrinksInPicker) {
                ForEach(AddNewDrinkViewModel.numberOfDrinksRange, id: \.self) { number in
                   Text("\(number)")
                }
            }
        }
    }
    
    private var abvSection: some View {
        Section(header: Text("Alcohol By Volume")) {
            Picker("Please add ABV in %", selection: $viewModel.alcoholByVolumeInPicker) {
                ForEach(AddNewDrinkViewModel.alcoholByVolumeRange, id: \.self) { abvVolume in
                   Text("\(String(format: "%.1f", abvVolume))")
                }
            }
        }
    }
}


