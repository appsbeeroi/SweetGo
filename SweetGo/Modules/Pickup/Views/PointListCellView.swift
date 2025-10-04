import SwiftUI

struct PointListCellView: View {
    
    let point: PickupPoint
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
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
                            .multilineTextAlignment(.leading)
                    }
                }
                
                Text(point.code)
                    .font(.impact(with: 20))
                    .foregroundStyle(.sgDarkRed)
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 10)
            .background(.white)
            .cornerRadius(30)
        }
    }
}

#Preview {
    PointListCellView(point: PickupPoint.mocks.first!) {}
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


extension UIApplication {
    static var keyWindow: UIWindow {
        shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .last!
    }
    
    class func topMostController(controller: UIViewController? = keyWindow.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topMostController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return topMostController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return topMostController(controller: presented)
        }
        return controller
    }
}
