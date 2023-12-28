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
                        }.disabled(limitSettingViewModel.viewState.saveButtonIsNotActive)
                    }
                }
            }
        }
    }
}


extension LimitSettingView {
    var infoText: some View {
        Text(limitSettingViewModel.viewState.infoText)
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
            .disabled(limitSettingViewModel.viewState.decrementButtonIsNotActive)
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
