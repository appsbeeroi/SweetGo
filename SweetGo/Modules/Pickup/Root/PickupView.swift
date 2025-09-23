import SwiftUI

struct PickupView: View {
    
    @Binding var isShowTabBar: Bool
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
    }
    
    private var navigation: some View {
        ZStack {
            Text("Pickup Points")
                .font(.impact(with: 35))
                .foregroundStyle(.sgDarkRed)
            
            HStack {
                Button {
                    //
                } label: {
                    RoundedRectangle(cornerRadius: 17)
                        .foregroundStyle(.sgPink)
                        .frame(width: 44, height: 44)
                        .overlay {
                            Image(systemName: "heart")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(.white)
                        }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    PickupView(isShowTabBar: .constant(false))
}
