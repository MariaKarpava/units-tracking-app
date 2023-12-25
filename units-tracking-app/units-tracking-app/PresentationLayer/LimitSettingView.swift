//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI

struct LimitSettingView: View {
    @ObservedObject var limitSettingViewModel: LimitSettingViewModel
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .center) {
                    Spacer()
                        .frame(height: 60)
                    infoText
                    Spacer()
                        .frame(height: 140)
                    buttonsWithUnits
                    Spacer()
                }
                .navigationTitle(limitSettingViewModel.viewState.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            limitSettingViewModel.saveLimitsTapped()
                        } label: {
                            Text("Save")
                                .underline()
                        }
                    }
                }
            }
        }
    }
}


extension LimitSettingView {
    // + TODO: was it a plan to use native back button?

    var infoText: some View {
        // + TODO: check alignment.
        Text("""
            According to the NHS, males should
            not exceed a daily limit of 8 units,
            while for females the value is 6 units. 
            
            Note: there is **no safe** amount of
            alcohol. The more alcohol you
            consume, the higher are the risks.
            """)
        .multilineTextAlignment(.center)
        .padding(.horizontal, 55)
    }
    
    var unitsIncrementer: some View {
        VStack(alignment: .center) {
            Text(String(format: "%.1f", limitSettingViewModel.viewState.units))
                .foregroundColor(.accentColor)
            Text("unit(s)")
                .foregroundColor(.secondaryText)
        }.font(.limitScreenUnits)
    }
    
    var buttonsWithUnits: some View {
        HStack {
            Spacer()
            Button {
                limitSettingViewModel.decrementUnitsTapped()
            } label: {
                customStepperButton(sign: "-", color: limitSettingViewModel.viewState.buttonColor)
            }
            .disabled(limitSettingViewModel.viewState.decrementButtonIsNotActive) // + TODO: this state never changes, but should!
            unitsIncrementer.frame(width: 100)
            Button {
                limitSettingViewModel.incrementUnitsTapped()
            } label: {
                customStepperButton(sign: "+", color: .accentColor)
            }
            Spacer()
        }
    }
    
    func customStepperButton(sign: String, color: Color) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(color, lineWidth: 2)
            .frame(width: 64, height: 64)
            .overlay(
                Text(sign)
                    .foregroundColor(color)
                    .font(.limitScreenStepperSign)
            )
    }

}


struct DailyLimit_Previews: PreviewProvider {
    static var previews: some View {
        let goalsService = GoalsService()
        let limitSettingViewModel = LimitSettingViewModel(goalsService: goalsService, limitType: .daily)
        return LimitSettingView(limitSettingViewModel: limitSettingViewModel)
    }
}
