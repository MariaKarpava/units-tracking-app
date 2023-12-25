//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI

// + TODO: naming: "LimitView" is not very descriptive name. Can you guess screen's responsibility based purely on this name?
struct LimitSettingView: View {
    @ObservedObject var limitSettingViewModel: LimitSettingViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 60)
                    infoText
                    .padding(.horizontal, 55)
                    Spacer()
                        .frame(height: 140)
                    buttonsWithUnits
                    Spacer()
                }
                .navigationTitle(limitSettingViewModel.viewState.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            limitSettingViewModel.saveLimitsTapped() // TODO: implement save logic
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
}


extension LimitSettingView {
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

    // + TODO: Here and in related places: "Title" would be a better name
    // + TODO: was it a plan to use native title instead of custom one and custom back button?

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
            Text(String(format: "%.1f", limitSettingViewModel.viewState.units))
                .foregroundColor(.mainText)
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
            .disabled(!limitSettingViewModel.viewState.areUnitsPositive) // + TODO: unitsAreValid -- what does it mean valid? Rename to smth more descriptive
            unitsIncrementer.frame(width: 100)
            Button {
                limitSettingViewModel.incrementUnitsTapped() // + TODO: here and in similar places: check naming convention. Views should never give orders to VMs.
            } label: {
                customStepperButton(sign: "+", color: .mainText)
            }
            Spacer()
        }
    }
    
    // + TODO: this func doesn't add anything
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
