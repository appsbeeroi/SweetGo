import SwiftUI

struct ShoppingCartView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var products: [Product]
    
    let saveAction: ([Product]) -> Void
    
    @State private var isShowConfirmationView = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                
                if products.isEmpty {
                    stumb
                } else {
                    VStack(spacing: 16) {
                        productsList
                        footer
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .animation(.easeInOut, value: products)
        }
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $isShowConfirmationView) {
            OrderConfirmationView(products: products)
        }
        .onChange(of: products) { products in
            if let index = products.firstIndex(where: { $0.quantity == 0 }) {
                self.products.remove(at: index)
            }
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text("Shopping cart")
                .font(.impact(with: 35))
                .foregroundStyle(.sgDarkRed)
            
            HStack {
                Button {
                    saveAction(products)
                } label: {
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundStyle(.basePink)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "arrow.backward")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 35)
    }
    
    private var stumb: some View {
        VStack(spacing: 20) {
            Image(.Images.Products.can)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 215)
            
            VStack(spacing: 16) {
                Text("Empty basket")
                    .font(.impact(with: 32))
                    .foregroundStyle(.sgDarkRed)
                
                Text("Choose fresh eggs or hens and add them to the basket. Delivery to convenient delivery point - fast and easy!")
                    .font(.impact(with: 16))
                    .foregroundStyle(.sgDarkRed.opacity(0.75))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 50)
        .background(.white)
        .cornerRadius(30)
        .padding(.top, 23)
    }
    
    private var productsList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 8) {
                ForEach($products) { product in
                    ShoppingCartProductCellView(product: product)
                }
            }
            .padding(.top, 13)
            .padding(.horizontal, 35)
        }
    }
    
    private var footer: some View {
        VStack(spacing: 16) {
            HStack {
                Text("Total in basket per amount")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.impact(with: 15))
                    .foregroundStyle(.sgDarkRed)
                
                let sum = products.reduce(0) { $0 + $1.totalPrice }
                
                Text(sum.formatted(.number.locale(Locale(identifier: "en_US"))) + " $")
                    .font(.impact(with: 45))
                    .foregroundStyle(.basePink)
            }
            
            Button {
                isShowConfirmationView.toggle()
            } label: {
                Text("Order")
                    .frame(height: 65)
                    .frame(maxWidth: .infinity)
                    .font(.impact(with: 25))
                    .foregroundStyle(.white)
                    .background(.basePink)
                    .cornerRadius(100)
            }
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 24)
    }
}

#Preview {
    ShoppingCartView(products: []) { _ in }
}

#Preview {
    ShoppingCartView(
        products: [
            Product(isMock: true),
            Product(isMock: true),
            Product(isMock: true),
            Product(isMock: true)
        ]) {_ in }
}

