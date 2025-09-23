import SwiftUI

struct ShoppingCartProductCellView: View {
    
    @Binding var product: Product
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 6) {
                Image(product.type.icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 56, height: 70)
                
                VStack(spacing: 10) {
                    Text(product.type.description)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 18))
                        .foregroundStyle(.sgDarkRed)
                        .multilineTextAlignment(.leading)
                    
                    Text(product.type.category)
                        .frame(height: 21)
                        .padding(.horizontal, 5)
                        .font(.impact(with: 11))
                        .foregroundStyle(.sgDarkRed)
                        .cornerRadius(7)
                        .overlay {
                            RoundedRectangle(cornerRadius: 7)
                                .stroke(.sgDarkRed, lineWidth: 1)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            
            HStack {
                HStack(spacing: 2) {
                    HStack(spacing: 8) {
                        HStack(spacing: 10) {
                            Button {
                                product.quantity -= 1
                            } label: {
                                Image(systemName: "minus")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.sgDarkRed)
                                    .padding(12)
                                    .contentShape(Rectangle())
                            }
                            
                            Text(product.quantity.formatted())
                                .font(.impact(with: 20))
                                .foregroundStyle(.sgPink)
                                .fixedSize()
                            
                            Button {
                                product.quantity += 1
                            } label: {
                                Image(systemName: "plus")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(.sgDarkRed)
                                    .padding(12)
                                    .contentShape(Rectangle())
                            }
                        }
                        .frame(height: 30)
                        .padding(.horizontal, 10)
                        .background(.sgLightPink)
                        .cornerRadius(20)
                    }
                    
                    Text(product.type.unit)
                        .font(.impact(with: 15))
                        .foregroundStyle(.sgDarkRed)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(product.totalPrice.formatted(.number.locale(Locale(identifier: "en_US"))) + " $")
                    .font(.impact(with: 25))
                    .foregroundStyle(.sgPink)
            }
        }
        .padding(10)
        .background(.white)
        .cornerRadius(30)
    }
}

#Preview {
    ShoppingCartProductCellView(product: .constant(Product(isMock: true)))
}
