import SwiftUI

enum AppRouteState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case products
    case pickup
    case orders
    case settings
    
    var icon: ImageResource {
        switch self {
            case .products:
                    .Images.TabBar.products
            case .pickup:
                    .Images.TabBar.pickup
            case .orders:
                    .Images.TabBar.orders
            case .settings:
                    .Images.TabBar.settings
        }
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

struct MetricsResponse {
    let isOrganic: Bool
    let url: String
    let parameters: [String: String]
}
