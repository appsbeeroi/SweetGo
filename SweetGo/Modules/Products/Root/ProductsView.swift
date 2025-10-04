import SwiftUI

struct ProductsView: View {
    
    @StateObject private var viewModel = ProductsViewModel()
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedProductType: ProductType?
    @State private var isShowAddProductView = false
    @State private var isShowCartView = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(.Images.BG)
                    .baseResizable()
                
                VStack {
                    navigation
                    products
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 20)
                .padding(.horizontal, 35)
            }
            .navigationDestination(isPresented: $isShowAddProductView) {
                AddProductView(type: selectedProductType ?? .candies) { productTupple in
                    viewModel.save(productTupple)
                }
            }
            .navigationDestination(isPresented: $isShowCartView) {
                ShoppingCartView(products: viewModel.products.filter { !$0.isOrdered }) { products in
                    viewModel.save(products)
                }
            }
            .onAppear {
                viewModel.loadProducts()
                isShowTabBar = true
            }
            .onChange(of: viewModel.isCloseNavigation) { isClose in
                if isClose {
                    isShowAddProductView = false
                    isShowCartView = false
                    viewModel.isCloseNavigation = false
                }
            }
        }
        .environmentObject(viewModel)
    }
    
    private var navigation: some View {
        ZStack {
            Text("Products")
                .font(.impact(with: 35))
                .foregroundStyle(.sgDarkRed)
            
            HStack {
                Button {
                    isShowTabBar = false
                    isShowCartView.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundStyle(.basePink)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "cart.fill")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
    
    private var products: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                let candies = viewModel.products.filter { $0.type == .candies }
                ProductsListCellView(type: .candies, products: candies) {
                    selectedProductType = .candies
                    isShowTabBar = false
                    isShowAddProductView.toggle()
                }
                
                let chocolates = viewModel.products.filter { $0.type == .chocolates }
                ProductsListCellView(type: .chocolates, products: chocolates) {
                    selectedProductType = .chocolates
                    isShowTabBar = false
                    isShowAddProductView.toggle()
                }
            }
            
            HStack(spacing: 10) {
                let cookies = viewModel.products.filter { $0.type == .cookies }
                ProductsListCellView(type: .cookies, products: cookies) {
                    selectedProductType = .cookies
                    isShowTabBar = false
                    isShowAddProductView.toggle()
                }
                
                let gifts = viewModel.products.filter { $0.type == .gifts }
                ProductsListCellView(type: .gifts, products: gifts) {
                    selectedProductType = .gifts
                    isShowTabBar = false
                    isShowAddProductView.toggle()
                }
            }
        }
    }
}

#Preview {
    ProductsView(isShowTabBar: .constant(false))
}

