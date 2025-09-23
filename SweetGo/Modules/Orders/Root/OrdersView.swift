import SwiftUI

struct OrdersView: View {
    
    @Binding var isShowTabBar: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
    }
    
    private var navigation: some View {
        Text("Your orders")
            .font(.impact(with: 35))
            .foregroundStyle(.sgDarkRed)
    }
}

#Preview {
    OrdersView(isShowTabBar: .constant(false))
}
