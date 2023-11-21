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
    @ObservedObject var historyViewModel: HistoryViewModel
    
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
                    HistoryView(historyViewModel: historyViewModel)
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
 
            
            ZStack {
                TabBarTopBorderVectorView()
                    .offset(y: -26.5)
                
                HStack {
                    ForEach((TabbedItems.allCases.prefix(2)), id: \.self){ item in
                        Button {
                            selectedTab = item
                        } label: {
                            addCustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item))
                        } .offset(y: 4)
                    }
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        addCustomMiddleButton()
                    }
                    .sheet(isPresented: $showSheet) {
                        AddNewDrinkView(viewModel: AddNewDrinkViewModel(drinksService: drinksService))
                    }
                    .offset(y: -6.5)

                    ForEach((TabbedItems.allCases.suffix(2)), id: \.self){ item in
                        Button {
                            selectedTab = item
                        } label: {
                            addCustomTabItem(imageName: item.iconName, title: item.title, isActive: (selectedTab == item))
                        } .offset(y: 4)
                    }
                    
                    
                }.frame(height: 49)
            }
            .background(.clear)
        }
    }
}


    
extension RootView {
    func addCustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        VStack() {
            VStack(alignment: .center) {
                Image(systemName: imageName)
                    .font(.system(size: 23))
                .foregroundColor(isActive ? .accent : .gray)
            }.frame(maxWidth: .infinity,
                    maxHeight: .infinity)
            VStack(alignment: .trailing) {
                Text(title)
                    .font(.system(size: 10))
                    .frame(maxWidth: .infinity)
                .foregroundColor(isActive ? .accent : .gray)
                
            }.offset(y: -3)
            Spacer().frame(height: 2)
        }
        .frame(maxWidth: .infinity, maxHeight: 49)
    }
    
    func addCustomMiddleButton() -> some View {
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






struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let drinksService = DrinksService()
        let goalsService = GoalsService()
        let homeViewModel = HomeViewModel(drinksService: drinksService, goalsService: goalsService)
        let historyViewModel = HistoryViewModel(drinksService: drinksService)
        
        RootView(homeViewModel: homeViewModel, historyViewModel: historyViewModel, drinksService: drinksService, goalsService: goalsService)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")

        RootView(homeViewModel: homeViewModel, historyViewModel: historyViewModel, drinksService: drinksService, goalsService: goalsService)
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
    }
}
