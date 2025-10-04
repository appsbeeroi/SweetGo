import SwiftUI

struct PickupFavoritesView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let points: [PickupPoint]
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                
                if points.isEmpty {
                    stumb
                } else {
                    pointsList
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden()
    }
    
    private var navigation: some View {
        ZStack {
            Text("Favorites")
                .font(.impact(with: 35))
                .foregroundStyle(.sgDarkRed)
            
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
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 35)
        }
    }
    
    private var stumb: some View {
        VStack(spacing: 20) {
            Image(.Images.Pickup.star)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 215)
            VStack(spacing: 16) {
                Text("No chosen")
                    .font(.impact(with: 32))
                    .foregroundStyle(.sgDarkRed)
                
                Text("Add delivery points to the favorites to quickly find them next time!")
                    .font(.impact(with: 16))
                    .foregroundStyle(.sgDarkRed)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 53)
        .padding(.vertical, 16)
        .background(.white)
        .cornerRadius(30)
    }
    
    private var pointsList: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 8) {
                ForEach(points) { point in
                    PointListCellView(point: point) {}
                        .disabled(true)
                }
            }
            .padding(.top, 16)
            .padding(.horizontal, 35)
        }
    }
}

#Preview {
    PickupFavoritesView(points: [PickupPoint.mocks.first!])
}

import SwiftUI
import SwiftUI
import CryptoKit
import WebKit
import AppTrackingTransparency
import UIKit
import FirebaseCore
import FirebaseRemoteConfig
import OneSignalFramework
import AdSupport


class OverlayPrivacyWindowController: UIViewController {
    var overlayView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overlayView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
