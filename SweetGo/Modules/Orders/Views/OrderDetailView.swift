import SwiftUI

struct OrderDetailView: View {
    
    @State var order: Order
    
    let saveAction: (Order) -> Void
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        image
                        
                        VStack(spacing: 24) {
                            name
                            products
                            points
                            
                            Spacer()
                            
                            statusButton
                        }
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 35)
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            .background(
                VStack {
                    Circle()
                        .frame(width: 520, height: 520)
                        .foregroundStyle(.white.opacity(0.3))
                }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .offset(y: -150)
            )
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        HStack {
            Button {
                saveAction(order)
            } label: {
                RoundedRectangle(cornerRadius: 17)
                    .foregroundStyle(.sgPink)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: "arrow.backward")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Image(order.status.icon)
            .resizable()
            .scaledToFit()
            .frame(width: 230, height: 210)
    }
    
    private var name: some View {
        Text(order.status.title)
            .font(.impact(with: 35))
            .foregroundStyle(.sgDarkRed)
    }
    
    private var products: some View {
        OrdersCellView(order: order) {}
            .disabled(true)
    }
    
    private var points: some View {
        VStack(spacing: 8) {
            Text("Pickup points")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
            
            PointListCellView(point: order.point ?? PickupPoint.mocks.first!) {}
        }
    }
    
    private var statusButton: some View {
        Button {
            order.status = .received
        } label: {
            Text("Mark as received")
                .frame(height: 65)
                .frame(maxWidth: .infinity)
                .font(.impact(with: 25))
                .background(order.status == .created ? .sgPink : .gray.opacity(0.5))
                .foregroundStyle(.white)
                .cornerRadius(100)
                .padding(.bottom, 24)
        }
        .disabled(order.status == .received)
    }
}

#Preview {
    OrderDetailView(order: Order()) { _ in }
}
