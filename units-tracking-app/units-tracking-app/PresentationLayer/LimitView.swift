//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct LimitView: View {
    @ObservedObject var limitViewModel: LimitViewModel
    
    let header: String
    
    var units: Double {
        var units: Double = 0
        if header == "Daily Limit" {
            units = limitViewModel.viewState.dailyLimit
            return units
        } else {
            units = limitViewModel.viewState.weeklyLimit
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
                        .foregroundColor(.mainText)
                Text("")
                }
            }
        }
        
    
    var body: some View {
            NavigationStack {
                GeometryReader { geometry in
                    VStack(alignment: .leading) {
                        Text(header)
                            .font(.limitScreenHeader)
                            .foregroundColor(.mainText)
                            .padding(20)
                        Spacer()
                            .frame(height: 60)
                        infoText
                        .padding(.horizontal, 55)
                        Spacer().frame(height: 140)
                        HStack {
                            Spacer()
                            Button {
                                if header == "Daily Limit" {
                                limitViewModel.decrementDailyLimitTapped()
                                } else {
                                    limitViewModel.decrementWeeklyLimitTapped()
                                }
                            } label: {
                                addCustomStepperButton(sign: "-")
                            }
                            .disabled(limitViewModel.viewState.dailyLimit <= 0)
                            unitsIncrementer.frame(width: 100)
                            Button {
                                if header == "Daily Limit" {
                                limitViewModel.incrementDailyLimitTapped()
                                } else {
                                    limitViewModel.incrementWeeklyLimitTapped()
                                }
                            } label: {
                                addCustomStepperButton(sign: "+")
                            }
                            .disabled(limitViewModel.viewState.dailyLimit > 99)
                            Spacer()
                        }
                        Spacer()
                    }
                        
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                print("save")
                            } label: {
                                Text("Save")
                                    .underline()
                                    .font(.limitScreenSaveButton)
                                    .foregroundColor(.mainText)
                            }
                        }
                }
                }

            } 
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: customBackButton)
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
        VStack(alignment: .center) {
            Text(String(format: "%.1f", units))
                .foregroundColor(.mainText)
            Text("unit(s)")
                .foregroundColor(.secondaryText)
        }.font(.limitScreenUnits)
    }
    
    func addCustomStepperButton(sign: String) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 2)
            .frame(width: 64, height: 64)
            .overlay(
                Text(sign)
                    .foregroundColor(.mainText)
                    .font(.limitScreenStepperSign)
            )
    }
    
    
}


struct DailyLimit_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let drinksService = DrinksService(goalsService: goalsService)
        let settingsViewModel = SettingsViewModel(goalsService: goalsService)
        let limitViewModel = LimitViewModel(goalsService: goalsService)
        return LimitView(limitViewModel: limitViewModel, header: "Daily Limit")
    }
}
