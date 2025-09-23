import SwiftUI

struct AppRouteView: View {
    
    @State private var selection: AppRouteState = .products
    @State private var isShowTabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            TabView(selection: $selection) {
                ProductsView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.products)
                
                PickupView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.pickup)
                
                OrdersView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.orders)
                
                SettingsView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.settings)
            }
            
            VStack {
                tabBar
                    .opacity(isShowTabBar ? 1 : 0)
                    .animation(.easeInOut, value: isShowTabBar)
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 24)
        }
    }
    
    private var tabBar: some View {
        HStack(spacing: 6) {
            ForEach(AppRouteState.allCases) { state in
                Button {
                    selection = state
                } label: {
                    RoundedRectangle(cornerRadius: 32)
                        .frame(width: 75, height: 75)
                        .foregroundStyle( state == selection ? .sgPink : .white)
                        .overlay {
                            Image(state.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(state == selection ? .white : .black)
                        }
                }
            }
        }
    }
}

#Preview {
    AppRouteView()
}



