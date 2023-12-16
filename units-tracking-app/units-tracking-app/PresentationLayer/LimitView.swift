//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct LimitView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    let header: String
    
    var units: Double {
        var units: Double = 0
        if header == "Daily Limit" {
            units = settingsViewModel.viewState.dailyLimit
            return units
        } else {
            units = settingsViewModel.viewState.weeklyLimit
            return units
        }
    }

    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

        var customBackButton : some View { 
            Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image(systemName: "chevron.left")
                Text("")
                }
            }
        }
        
    
    var body: some View {
        VStack {
            Spacer().frame(height: 30)
            NavigationStack {
                VStack(alignment: .leading) {
                    Text(header)
                        .font(.settingsScreenHeader)
                        .foregroundColor(.mainText)
                    VStack {
                        Spacer().frame(height: 60)
                        infoText
                        Spacer().frame(height: 140)
                        HStack {
                            Button {
                                settingsViewModel.decrementDailyLimitTapped()
                            } label: {
                                addCustomStepperButton(sign: "-")
                            }.disabled(settingsViewModel.viewState.dailyLimit <= 0)
                            unitsIncrementer
                            Button {
                                settingsViewModel.incrementDailyLimitTapped()
                            } label: {
                                addCustomStepperButton(sign: "+")
                            }.disabled(settingsViewModel.viewState.dailyLimit > 99)
                        }
                        
                        Spacer()
                    }
                    
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            print("save")
                        } label: {
                            Text("Save")
                                .underline() 
                                .foregroundColor(.mainText)
                        }
                    }
                }

            } .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: customBackButton)
        }
    }
    
    var infoText: some View {
        Text("""
            According to the NHS, males should 
            not exceed a daily limit of 8 units,
            while for females the value is 6 units. 
            
            Note: there is **no safe** amount of
            alcohol. The more alcohol you
            consume, the higher are the risks.
            """)
    }
    
    var unitsIncrementer: some View {
        VStack {
            Text(String(format: "%.1f", units))
            Text("unit(s)")
        }.frame(width: 120, height: 64)
    }
    
    func addCustomStepperButton(sign: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 64, height: 64)
            .overlay(Text(sign))
    }
    
    
}


struct DailyLimit_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let drinksService = DrinksService(goalsService: goalsService)
        let settingsViewModel = SettingsViewModel(drinksService: drinksService, goalsService: goalsService)
        return LimitView(settingsViewModel: settingsViewModel, header: "Daily Limit")
    }
}
