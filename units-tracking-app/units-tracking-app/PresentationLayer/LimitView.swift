//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct LimitView: View {
    @ObservedObject var limitViewModel: LimitViewModel
    
//    var units: Double {
//        var units: Double = 0
//        if limitViewModel.viewState.header == "Daily Limit" {
//            units = limitViewModel.viewState.dailyLimit
//            return units
//        } else {
//            units = limitViewModel.viewState.weeklyLimit
//            return units
//        }
//    }
   
    
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
                        Text(limitViewModel.viewState.header)
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
                                limitViewModel.decrementUnits()
                            } label: {
                                addCustomStepperButton(sign: "-")
                            }
//                            .disabled(!viewSateIsValid(header: limitViewModel.viewState.header))
                            unitsIncrementer.frame(width: 100)
                            Button {
                                limitViewModel.incrementUnits()
                            } label: {
                                addCustomStepperButton(sign: "+")
                            }
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
    
//    var dailyViewStateIsValid: Bool {
//        return limitViewModel.viewState.dailyLimit > 0
//    }
//    
//    var weeklyViewStateIsValid: Bool {
//        return limitViewModel.viewState.weeklyLimit > 0
//    }
//    
//    func viewSateIsValid(header: String) -> Bool {
//        if header == "Daily Limit" {
//            dailyViewStateIsValid
//        } else {
//            weeklyViewStateIsValid
//        }
//    }
//    
//    var buttonColor: Color {
//        return viewSateIsValid(header: limitViewModel.viewState.header) ? .mainText : .secondaryText
//    }

    
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
            Text(String(format: "%.1f", limitViewModel.viewState.units))
                .foregroundColor(.mainText)
            Text("unit(s)")
                .foregroundColor(.secondaryText)
        }.font(.limitScreenUnits)
    }
    
    func addCustomStepperButton(sign: String) -> some View {
//        var color: Color = .mainText
//        if sign == "-" {
//            color = buttonColor
//        }
        
        return RoundedRectangle(cornerRadius: 10)
//            .stroke(buttonColor, lineWidth: 2)
            .stroke(Color.blue, lineWidth: 2)
            .frame(width: 64, height: 64)
            .overlay(
                Text(sign)
                    .foregroundColor(.blue)
                    .font(.limitScreenStepperSign)
            )
    }
}


struct DailyLimit_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let limitViewModel = LimitViewModel(goalsService: goalsService, limitType: .daily)
        return LimitView(limitViewModel: limitViewModel)
    }
}
