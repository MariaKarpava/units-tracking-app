//
//  CustomTabBar.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 14/09/2023.
//

import SwiftUI
import CoreGraphics


struct TestScreen: View {
    var body: some View {
        VStack {
            Text("Hello World")
            Spacer()
            CustomTabBar()
        }
    }
}



struct CustomTabBar: View {
    @State private var tabBarHeight: CGFloat = 0
    @State private var tabBarWidth: CGFloat = 0
    
    @State private var isButton1Tapped = false
    @State private var isButton2Tapped = false
    @State private var isButton3Tapped = false
    @State private var isButton4Tapped = false
    
    var body: some View {
        
        GeometryReader { geometry0 in
            VStack {
                Text("Tab Bar Height: \(tabBarHeight)")
                Text("Tab Bar Width: \(tabBarWidth)")
                
                Spacer()
                
                GeometryReader { geometry in
                    
                    TopBorderVectorView().offset(y: 35)
                    
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            Button(action: {
                                // Switch to Home
                                isButton1Tapped.toggle()
                                isButton2Tapped = false
                                isButton3Tapped = false
                                isButton4Tapped = false
                                
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "house")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("Home")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(isButton1Tapped ? Color.blue : Color.black)
                            }
                            
                            Button(action: {
                                // Switch to Stats
                                isButton2Tapped.toggle()
                                isButton1Tapped = false
                                isButton3Tapped = false
                                isButton4Tapped = false
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "chart.xyaxis.line")
                                        .font(.system(size: 23))
                                    Text("Stats")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(isButton1Tapped ? Color.blue : Color.black)
                            }
                            
                            Button(action: {
                                // Add Button Action
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .fill(
                                            LinearGradient(colors: [Color("AddButtonUpperColor"), Color("AddButtonBottomColor")], startPoint: .top, endPoint: .bottom)
                                        )
                                        .frame(width: 64, height: 64)
                                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(Color.white)
//                                        .font(.system(size: 27))
                                        .font(Font.system(size: 30, weight: .medium))
//
                                        
                                }
                            } .offset(y: -13)
                            
                            Button(action: {
                                // Switch to History
                                isButton3Tapped.toggle()
                                isButton1Tapped = false
                                isButton2Tapped = false
                                isButton4Tapped = false
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "list.bullet")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("History")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(isButton1Tapped ? Color.blue : Color.black)
                            }
                            
                            Button(action: {
                                // Switch to Settings
                                isButton4Tapped.toggle()
                                isButton1Tapped = false
                                isButton2Tapped = false
                                isButton3Tapped = false
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("Settings")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(isButton1Tapped ? Color.blue : Color.black)
                            }
                            Spacer(minLength: 0)
                        }
                        .padding()
    //                    .background(Color.blue)
    //                    .opacity(0.2)
    //                    .border(Color.blue)
                        .onAppear {
                            tabBarHeight = geometry.size.height
                            tabBarWidth = geometry.size.width
                    }
                }
                .frame(height: 77)
            }
        }
    }
}





struct TopBorderVector: View {
    var body: some View {
        EmptyView()
    }
}




struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        TestScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        TestScreen()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}
