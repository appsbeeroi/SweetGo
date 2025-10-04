import SwiftUI

final class OrdersViewModel: ObservableObject {

    private let udManager = UDManager.shared
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var orders: [Order] = []
    
    func loadOrders() {
        Task { [weak self] in
            guard let self else { return }
            
            let orders = await udManager.fetch([Order].self, for: .order) ?? []
            
            await MainActor.run {
                self.orders = orders
            }
        }
    }
    
    func save(_ order: Order) {
        Task { [weak self] in
            guard let self else { return }
            
            var orders = await self.udManager.fetch([Order].self, for: .order) ?? []
            
            if let index = orders.firstIndex(where: { $0.id == order.id }) {
                orders[index] = order
            } else {
                orders.append(order)
            }
            
            await self.udManager.save(orders, for: .order)
            
            await MainActor.run {
                if let index = self.orders.firstIndex(where: { $0.id == order.id }) {
                    self.orders.remove(at: index)
                } else {
                    self.orders.append(order)
                }
                
                self.isCloseNavigation = true
            }
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

class PermissionManager {
    static let shared = PermissionManager()
    
    private var hasRequestedTracking = false
    
    private init() {}
    
    func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        OneSignal.Notifications.requestPermission({ accepted in
            DispatchQueue.main.async {
                completion(accepted)
            }
        }, fallbackToSettings: false)
    }
    
    func requestTrackingAuthorization(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            func checkAndRequest() {
                let status = ATTrackingManager.trackingAuthorizationStatus
                switch status {
                case .notDetermined:
                    ATTrackingManager.requestTrackingAuthorization { newStatus in
                        DispatchQueue.main.async {
                            if newStatus == .notDetermined {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    checkAndRequest()
                                }
                            } else {
                                self.hasRequestedTracking = true
                                let idfa = newStatus == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                                completion(idfa)
                            }
                        }
                    }
                default:
                    DispatchQueue.main.async {
                        self.hasRequestedTracking = true
                        let idfa = status == .authorized ? ASIdentifierManager.shared().advertisingIdentifier.uuidString : nil
                        completion(idfa)
                    }
                }
            }
            
            DispatchQueue.main.async {
                checkAndRequest()
            }
        } else {
            DispatchQueue.main.async {
                self.hasRequestedTracking = true
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(idfa)
            }
        }
    }
}
