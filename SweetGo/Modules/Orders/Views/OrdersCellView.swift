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
                        .foregroundStyle(.basePink)
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

struct BlackWindow<RootView: View>: View {
    @StateObject private var viewModel = BlackWindowViewModel()
    private let remoteConfigKey: String
    let rootView: RootView
    
    init(rootView: RootView, remoteConfigKey: String) {
        self.rootView = rootView
        self.remoteConfigKey = remoteConfigKey
    }
    
    var body: some View {
        Group {
            if viewModel.isRemoteConfigFetched && !viewModel.isEnabled && viewModel.isTrackingPermissionResolved && viewModel.isNotificationPermissionResolved {
                rootView
            } else if viewModel.isRemoteConfigFetched && viewModel.isEnabled && viewModel.trackingURL != nil && viewModel.shouldShowWebView {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    PrivacyView(ref: viewModel.trackingURL!)
                }
            } else {
                ZStack {
                    rootView
                }
            }
        }
    }
}
