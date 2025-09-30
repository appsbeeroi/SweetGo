import SwiftUI

struct OrdersView: View {
    
    @StateObject private var viewModel = OrdersViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State var selectedOrder: Order?
    @State private var isShowDetailView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.BG)
                    .baseResizable()
                
                VStack {
                    navigation
                    
                    if viewModel.orders.isEmpty {
                        stumb
                    } else {
                        orders
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
            }
            .navigationDestination(isPresented: $isShowDetailView) {
                OrderDetailView(order: selectedOrder ?? Order()) { order in
                    viewModel.save(order)
                }
            }
            .onAppear {
                viewModel.loadOrders()
                isShowTabBar = true
                selectedOrder = nil
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    isShowDetailView = false
                    viewModel.isCloseNavigation = false 
                }
            }
        }
    }
    
    private var navigation: some View {
        Text("Your orders")
            .font(.impact(with: 35))
            .foregroundStyle(.sgDarkRed)
    }
    
    private var stumb: some View {
        VStack(spacing: 20) {
            Image(.Images.Orders.can)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 215)
            
            VStack(spacing: 16) {
                Text("You have no orders")
                    .font(.impact(with: 32))
                    .foregroundStyle(.sgDarkRed)
                
                Text("It seems that you have not ordered anything yet. Choose sweets from the catalog and make your first order - let the day taste better!")
                    .font(.impact(with: 16))
                    .foregroundStyle(.sgDarkRed.opacity(0.75))
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
        .background(.white)
        .cornerRadius(30)
        .padding(.top, 16)
    }
    
    private var orders: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.orders) { order in
                    OrdersCellView(order: order) {
                        isShowTabBar = false
                        selectedOrder = order
                        isShowDetailView.toggle()
                    }
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    OrdersView(isShowTabBar: .constant(false))
}

