import SwiftUI

struct AddProductView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let type: ProductType
    
    let saveAction: ((type: ProductType, quantity: Int)) -> Void
    
    @State private var quantity = 1
    @State private var isShowResultView = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 36) {
                        image
                        
                        VStack(spacing: 24) {
                            title
                            category
                            description
                            counter
                            price
                            addButton
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .padding(.horizontal, 35)
            .background(
                VStack {
                    Circle()
                        .frame(width: 520, height: 520)
                        .foregroundStyle(.white.opacity(0.3))
                }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .offset(y: -150)
            )
            
            if isShowResultView {
                result
            }
        }
        .navigationBarBackButtonHidden()
        .animation(.easeInOut, value: isShowResultView)
    }
    
    private var navigation: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 17)
                    .frame(width: 44, height: 44)
                    .foregroundStyle(.sgPink)
                    .overlay {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var image: some View {
        Image(type.icon)
            .resizable()
            .scaledToFit()
            .frame(width: 215, height: 270)
    }
    
    private var title: some View {
        Text(type.title)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.impact(with: 35))
            .foregroundStyle(.sgDarkRed)
            .multilineTextAlignment(.leading)
    }
    
    private var category: some View {
        VStack(spacing: 10) {
            Text("Category")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 13))
                .foregroundStyle(.sgLightBrown.opacity(0.7))
            
            Text(type.category)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
        }
    }
    
    private var description: some View {
        VStack(spacing: 10) {
            Text("Description")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 13))
                .foregroundStyle(.sgLightBrown.opacity(0.7))
            
            Text(type.description)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
        }
    }
    
    private var counter: some View {
        HStack(spacing: 8) {
            HStack(spacing: 10) {
                Button {
                    quantity -= 1
                } label: {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(quantity == 1 ? .sgLightBrown.opacity(0.7) : .sgDarkRed)
                        .padding(12)
                        .contentShape(Rectangle())
                }
                .disabled(quantity == 1)
                
                Text(quantity.formatted())
                    .font(.impact(with: 20))
                    .foregroundStyle(.sgPink)
                
                Button {
                    quantity += 1
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
            .background(.white)
            .cornerRadius(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    private var price: some View {
        Text((type.price * Double(quantity)).formatted(.number.locale(Locale(identifier: "en_US"))) + " $")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.impact(with: 45))
            .foregroundStyle(.sgPink)
            .animation(.default, value: quantity)
    }
    
    private var addButton: some View {
        Button {
            isShowResultView.toggle()
        } label: {
            Text("Add to cart")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.impact(with: 25))
                .background(.sgPink)
                .foregroundStyle(.white)
                .cornerRadius(100)
        }
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
                    saveAction((type, quantity))
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
    AddProductView(type: .candies) { _ in }
}
