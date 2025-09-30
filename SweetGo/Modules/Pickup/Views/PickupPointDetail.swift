import SwiftUI

struct PickupPointDetail: View {
    
    @State var pickup: PickupPoint
    
    let favorites: [PickupPoint]
    
    let saveAction: (PickupPoint) -> Void
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 8) {
                        image
                        code
                        
                        VStack(spacing: 24) {
                            name
                            geo
                            schedule
                            comments
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
        .onAppear {
            if favorites.contains(pickup) {
                self.pickup.isFavorite = true
            }
        }
    }
    
    private var navigation: some View {
        HStack {
            Button {
                saveAction(pickup)
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
            
            Spacer()
            
            Button {
                pickup.isFavorite.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 17)
                    .foregroundStyle(.sgPink)
                    .frame(width: 44, height: 44)
                    .overlay {
                        Image(systemName: pickup.isFavorite ? "heart.fill" : "heart")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundStyle(.white)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 35)
    }
    
    private var image: some View {
        Image(.Images.Pickup.point)
            .resizable()
            .scaledToFit()
            .frame(width: 180, height: 215)
    }
    
    private var code: some View {
        VStack {
            Text("Code")
                .font(.impact(with: 18))
                .foregroundStyle(.sgDarkRed.opacity(0.75))
            
            Text(pickup.code)
                .font(.impact(with: 24))
                .foregroundStyle(.sgDarkRed)
        }
    }
    
    private var name: some View {
        Text(pickup.name)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 40)
            .font(.impact(with: 35))
            .foregroundStyle(.sgDarkRed)
    }
    
    private var geo: some View {
        HStack(spacing: 4) {
            Image(.Images.Pickup.mapPoint)
                .resizable()
                .scaledToFit()
                .frame(width: 23, height: 23)
                .foregroundStyle(.sgPink)
            
            Text(pickup.address)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 16))
                .foregroundStyle(.sgDarkRed)
        }
    }
    
    private var schedule: some View {
        VStack(spacing: 8) {
            Text("Schedule")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 14))
                .foregroundStyle(.sgDarkRed.opacity(0.75))
            
            Text(pickup.schedule)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
        }
    }
    
    private var comments: some View {
        VStack(spacing: 8) {
            Text("Comments")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 14))
                .foregroundStyle(.sgDarkRed.opacity(0.75))
            
            Text(pickup.comments)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.impact(with: 20))
                .foregroundStyle(.sgDarkRed)
        }
    }
}

#Preview {
    PickupPointDetail(pickup: PickupPoint.mocks.first!, favorites: []) { _ in }
}
