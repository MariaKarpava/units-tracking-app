//
//  DailyLimit.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 13/12/2023.
//

import SwiftUI


struct LimitView: View {
    @ObservedObject var limitViewModel: LimitViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(alignment: .leading) {
                    header
                    Spacer()
                        .frame(height: 60)
                    infoText
                    .padding(.horizontal, 55)
                    Spacer()
                        .frame(height: 140)
                    buttonsWithUnits
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
}


extension LimitView {
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

    var header: some View {
        Text(limitViewModel.viewState.header)
            .font(.limitScreenHeader)
            .foregroundColor(.mainText)
            .padding(20)
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
            Text(String(format: "%.1f", limitViewModel.viewState.units))
                .foregroundColor(.mainText)
            Text("unit(s)")
                .foregroundColor(.secondaryText)
        }.font(.limitScreenUnits)
    }
    
    var buttonsWithUnits: some View {
        HStack {
            Spacer()
            Button {
                limitViewModel.decrementUnits()
            } label: {
                addCustomStepperButton(sign: "-", color: limitViewModel.viewState.buttonColor)
            }
            .disabled(!limitViewModel.viewState.unitsAreValid)
            unitsIncrementer.frame(width: 100)
            Button {
                limitViewModel.incrementUnits()
            } label: {
                addCustomStepperButton(sign: "+", color: .mainText)
            }
            Spacer()
        }
    }
    
    func addCustomStepperButton(sign: String, color: Color) -> some View {
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
        let limitViewModel = LimitViewModel(goalsService: goalsService, limitType: .daily)
        return LimitView(limitViewModel: limitViewModel)
    }
}
