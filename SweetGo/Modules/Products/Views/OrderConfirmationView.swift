import SwiftUI

struct OrderConfirmationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var viewModel: ProductsViewModel
    
    @State private var order: Order
    @State private var isShowResult = false
    
    init(products: [Product]) {
        let type = products.first?.type ?? .candies
        self._order = State(initialValue: Order(productType: type, products: products))
    }
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                
                VStack(spacing: 24) {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24) {
                            product
                            points
                        }
                    }
                    
                    footer
                }
                .animation(.easeIn(duration: 0.3), value: order)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            
            if isShowResult {
                result
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.easeInOut, value: isShowResult)
    }
    
    private var navigation: some View {
        HStack {
            Button {
                dismiss()
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
            
            Text("Order Confirmation")
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.impact(with: 35))
                .foregroundStyle(.sgDarkRed)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .padding(.horizontal, 35)
    }
    
    private var product: some View {
        VStack(spacing: 8) {
            Text("Product")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
            
            HStack(spacing: 6) {
                Image(order.productType.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 88)
                
                VStack(spacing: 10) {
                    HStack(spacing: 16) {
                        Text(order.productType.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 18))
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.sgDarkRed)
                        
                        Text(order.productType.category)
                            .frame(height: 21)
                            .padding(.horizontal, 5)
                            .font(.impact(with: 11))
                            .foregroundStyle(.sgDarkRed)
                            .cornerRadius(7)
                            .overlay {
                                RoundedRectangle(cornerRadius: 7)
                                    .stroke(.sgDarkRed, lineWidth: 1)
                            }
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .frame(minHeight: 34)
                    
                    let sum = order.products.reduce(0) { $0 + $1.totalPrice }
                    
                    Text(sum.formatted(.number.locale(Locale(identifier: "en_US"))) + " $")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 25))
                        .foregroundStyle(.basePink)
                }
            }
            .padding(10)
            .background(.white)
            .cornerRadius(30)
        }
        .padding(.horizontal, 35)
    }
    
    private var points: some View {
        VStack(spacing: 8) {
            Text("Product")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
            
            LazyVStack(spacing: 8) {
                if let point = order.point {
                    PointCellView(point: point, selectedPoint: $order.point)
                } else {
                    ForEach(PickupPoint.mocks) { point in
                        PointCellView(point: point, selectedPoint: $order.point)
                    }
                }
            }
        }
        .padding(.horizontal, 35)
    }
    
    private var footer: some View {
        VStack(spacing: 24) {
            Button {
                isShowResult.toggle()
            } label: {
                Text("Order")
                    .frame(height: 65)
                    .frame(maxWidth: .infinity)
                    .font(.impact(with: 25))
                    .background(order.isLock ? .gray.opacity(0.5): .basePink)
                    .foregroundStyle(.white)
                    .cornerRadius(100)
            }
            .disabled(order.isLock)
        }
        .padding(.horizontal, 35)
        .padding(.bottom, 24)
    }
    
    private var result: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
            
            ZStack {
                VStack(spacing: 10) {
                    Image(.Images.Products.result)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                    
                    Text("Added to cart")
                        .font(.impact(with: 35))
                        .foregroundStyle(.sgDarkRed)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 30)
            .background(.white)
            .cornerRadius(35)
            .padding(.horizontal, 35)
            .overlay(alignment: .topTrailing) {
                Button {
                    viewModel.save(order)
                } label: {
                    Image(systemName: "multiply.circle.fill")
                        .padding(.top)
                        .padding(.trailing, 45)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(.gray.opacity(1))
                }
            }
        }
        .transition(.opacity)
    }
}

#Preview {
    OrderConfirmationView(products: [Product(isMock: true)])
        .environmentObject(ProductsViewModel())
}

