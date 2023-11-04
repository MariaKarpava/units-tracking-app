//
//  CustomTabBar.swift
//  units-tracking-app
//
//  Created by Maryia Karpava on 14/09/2023.
//

import SwiftUI
import CoreGraphics


struct HistoryView2: View {
    var body: some View {
        Text("History View 2")
    }
}


enum TabbedItems: Int, CaseIterable {
    case home
    case stats
    case history
    case settings
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .stats:
            return "Stats"
        case .history:
            return "History"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String{
            switch self {
            case .home:
                return "house"
            case .stats:
                return "chart.xyaxis.line"
            case .history:
                return "list.bullet"
            case .settings:
                return "gearshape"
            }
        }
}

struct RootView: View {
    @State var selectedTab: TabbedItems = .home
    @ObservedObject var homeViewModel: HomeViewModel
    
    @State private var showSheet = false
    var drinksService: DrinksService
    var goalsService: GoalsService
    
    var body: some View {
        VStack(spacing: 0.0) {
            Group {
                switch selectedTab {
                case .home:
                    HomeView(homeViewModel: homeViewModel)
                case .stats:
                    StatisticsView()
                case .history:
                    HistoryView2()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .background(.yellow)
 
            
            ZStack {
                TopBorderVectorView()
                    .offset(y: -26.5)
                
                HStack {
                    ForEach((TabbedItems.allCases.prefix(2)), id: \.self){ item in
                        Button {
                            selectedTab = item
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item))
                        }
                    }
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        customMiddleButton()
                    }
                    .sheet(isPresented: $showSheet) {
                        AddNewDrinkView(viewModel: AddNewDrinkViewModel(drinksService: drinksService))
                    }
                    .offset(y: -6.5)

                    ForEach((TabbedItems.allCases.suffix(2)), id: \.self){ item in
                        Button {
                            selectedTab = item
                        } label: {
                            CustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item))
                        }
                    }
                    
                    
                }.frame(height: 49)
            }
            .background(.clear)
                
        }
//        .background(.gray)
    }
}

extension RootView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        VStack(alignment: .center, spacing: 5){
            Image(systemName: imageName)
                .font(.system(size: 23))
                .foregroundColor(isActive ? .accent : .gray)
            Text(title)
                .font(.system(size: 10))
                .frame(maxWidth: .infinity)
                .foregroundColor(isActive ? .accent : .gray)
        }
        .frame(maxWidth: .infinity)
    }
    
    func customMiddleButton() -> some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(
                    LinearGradient(colors: [Color.addButtonTopColor, Color.addButtonBottomColor], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 64, height: 64)
            Image(systemName: "plus")
                .foregroundColor(Color.white)
                .font(Font.system(size: 30, weight: .medium))
        }
    }
}















struct CustomTabBar: View {
    @State private var tabBarHeight: CGFloat = 0
    @State private var tabBarWidth: CGFloat = 0
    
    
    var body: some View {
        GeometryReader { geometry0 in
            VStack {
                Spacer()
                GeometryReader { geometry in
                    
                    TopBorderVectorView()
                        .offset(y: 35)
                        .border(.red)
                    
                        HStack(alignment: .center, spacing: 0) {
                            Spacer(minLength: 0)
                            Button(action: {
                                // Switch to Home
                                
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "house")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("Home")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
                            }
                            
                            Button(action: {
                                // Switch to Stats
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "chart.xyaxis.line")
                                        .font(.system(size: 23))
                                    Text("Stats")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
                            }
                            
                            Button(action: {
                                // Add Button Action
                            }) {
                                ZStack(alignment: .center) {
                                    Circle()
                                        .fill(
                                            LinearGradient(colors: [Color.addButtonTopColor, Color.addButtonBottomColor], startPoint: .top, endPoint: .bottom)
                                        )
                                        .frame(width: 64, height: 64)
                                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(Color.white)
//                                        .font(.system(size: 27))
                                        .font(Font.system(size: 30, weight: .medium))
                                        
                                }
                            } .offset(y: -13)
                            
                            Button(action: {
                                // Switch to History
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "list.bullet")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("History")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
                            }
                            
                            Button(action: {
                                // Switch to Settings
                            }) {
                                VStack(alignment: .center, spacing: 5) {
                                    Image(systemName: "gearshape")
                                        .font(.system(size: 23))
//                                        .border(Color.red)
                                    Text("Settings")
                                        .font(.system(size: 10))
                                }
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.black)
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
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        let homeViewModel = HomeViewModel(drinksService: drinksService, goalsService: goalsService)
        
        RootView(homeViewModel: homeViewModel, drinksService: drinksService, goalsService: goalsService)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        RootView(homeViewModel: homeViewModel, drinksService: drinksService, goalsService: goalsService)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}
