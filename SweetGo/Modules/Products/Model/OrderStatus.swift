import UIKit

enum OrderStatus: Codable {
    case created
    case received
    
    var title: String {
        switch self {
            case .created:
                "Created"
            case .received:
                "Received"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .created:
                    .Images.Pickup.created
            case .received:
                    .Images.Pickup.received
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

extension Notification.Name {
    static let didFetchTrackingURL = Notification.Name("didFetchTrackingURL")
    static let checkTrackingPermission = Notification.Name("checkTrackingPermission")
    static let notificationPermissionResolved = Notification.Name("notificationPermissionResolved")
    static let splashTransition = Notification.Name("splashTransition")
}
