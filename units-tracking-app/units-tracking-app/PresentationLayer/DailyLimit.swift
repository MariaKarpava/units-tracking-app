//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct DailyLimit: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

        var customBackButton : some View { Button(action: {
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
                    Text("Daily Limit")
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
                            unitsIncrement
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
                       Button("Save") {
                          print("save")
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
            
            Note: there is no safe amount of
            alcohol. The more alcohol you
            consume, the higher are the risks.
            """)
    }
    
    var unitsIncrement: some View {
        VStack {
            Text(String(format: "%.1f", settingsViewModel.viewState.dailyLimit))
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
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        return DailyLimit(settingsViewModel: SettingsViewModel(drinksService: drinksService, goalsService: goalsService))
    }
}
