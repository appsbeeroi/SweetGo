import SwiftUI

struct PointCellView: View {
    
    let point: PickupPoint
    
    @Binding var selectedPoint: PickupPoint?
    
    var body: some View {
        Button {
            selectedPoint = point == selectedPoint ? nil : point
        } label: {
            HStack(spacing: 6) {
                Circle()
                    .stroke(.basePink, lineWidth: 1)
                    .frame(width: 27, height: 27)
                    .overlay {
                        if selectedPoint == point {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundStyle(.basePink)
                        }
                    }
                
                VStack(spacing: 0) {
                    HStack(spacing: 4) {
                        Image(.Images.Pickup.point)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 29, height: 35)
                        
                        Text(point.name)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.impact(with: 20))
                            .foregroundStyle(.sgDarkRed)
                    }
                    
                    HStack(spacing: 4) {
                        Image(.Images.Pickup.mapPoint)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                            .foregroundStyle(.basePink)
                        
                        Text(point.address)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.impact(with: 14))
                            .foregroundStyle(.sgDarkRed.opacity(0.75))
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .background(.white)
            .cornerRadius(30)
        }
    }
}

