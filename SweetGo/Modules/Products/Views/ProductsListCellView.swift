import SwiftUI

struct ProductsListCellView: View {
    
    var type: ProductType
    var products: [Product]
    
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 14) {
            Image(type.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 115)
            
            HStack {
                VStack(spacing: 10) {
                    Text(type.category)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 13))
                        .foregroundStyle(.sgDarkRed)
                    
                    let sum = products.reduce(0) { $0 + $1.totalPrice }
                    
                    Text("\(sum.formatted()) $")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.impact(with: 24))
                        .foregroundStyle(.sgPink)
                }
                
                VStack {
                    Button {
                        action()
                    } label:{
                        RoundedRectangle(cornerRadius: 7)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(.sgPink)
                            .background(
                                Rectangle()
                                    .padding(12)
                                    .contentShape(Rectangle())
                            )
                            .overlay {
                                Image(systemName: "plus")
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(.white)
                            }
                    }
                    .frame(width: 40, height: 40)
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .frame(height: 190)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .padding(.horizontal, 7)
        .background(.white)
        .cornerRadius(30)
    }
}
