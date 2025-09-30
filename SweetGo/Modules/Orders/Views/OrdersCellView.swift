import SwiftUI

struct OrdersCellView: View {
    
    let order: Order
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 6) {
                Image(order.productType.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 88)
                
                VStack(spacing: 6) {
                    Text(order.productType.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 18))
                        .foregroundStyle(.sgDarkRed)
                        .multilineTextAlignment(.leading)
                    
                    let productsSum = order.products.compactMap { $0.totalPrice }
                    let totalSum = productsSum.reduce(0, +)
                    
                    Text(totalSum.formatted(.number.locale(Locale(identifier: "en_US"))) + " $")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 25))
                        .foregroundStyle(.sgPink)
                }
                
                VStack {
                    Text(order.productType.category)
                        .frame(height: 21)
                        .padding(.horizontal, 6)
                        .font(.impact(with: 11))
                        .foregroundStyle(.sgDarkRed)
                        
                        .cornerRadius(7)
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(.sgDarkRed, lineWidth: 1)
                        }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .padding(.vertical, 21)
            .frame(height: 130)
            .padding(.horizontal, 10)
            .background(.white)
            .cornerRadius(30)
        }
    }
}

#Preview {
    ZStack {
        Color.gray
        
        OrdersCellView(order: Order()) {}
            .padding(.horizontal, 30)
    }
}
