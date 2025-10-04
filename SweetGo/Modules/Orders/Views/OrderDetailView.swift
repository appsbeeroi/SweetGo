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
                .background(order.status == .created ? .basePink : .gray.opacity(0.5))
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

struct TrackingURLBuilder {
    static func buildTrackingURL(from response: MetricsResponse, idfa: String?, bundleID: String) -> URL? {
        let onesignalId = OneSignal.User.onesignalId
        
        if response.isOrganic {
            guard var components = URLComponents(string: response.url) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = components.queryItems ?? []
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
            } else {
                print("OneSignal ID not available for organic URL")
            }
            
            components.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let url = components.url else {
                return nil
            }
            print(url)
            return url
        } else {
            let subId2 = response.parameters["sub_id_2"]
            let baseURLString = subId2 != nil ? "\(response.url)/\(subId2!)" : response.url
            
            guard var newComponents = URLComponents(string: baseURLString) else {
                return nil
            }
            
            var queryItems: [URLQueryItem] = []
            queryItems = response.parameters
                .filter { $0.key != "sub_id_2" }
                .map { URLQueryItem(name: $0.key, value: $0.value) }
            queryItems.append(URLQueryItem(name: "bundle", value: bundleID))
            if let idfa = idfa {
                queryItems.append(URLQueryItem(name: "idfa", value: idfa))
            }
            
            // Add OneSignal ID
            if let onesignalId = onesignalId {
                queryItems.append(URLQueryItem(name: "onesignal_id", value: onesignalId))
                print("🔗 Added OneSignal ID to non-organic URL: \(onesignalId)")
            } else {
                print("⚠️ OneSignal ID not available for non-organic URL")
            }
            
            newComponents.queryItems = queryItems.isEmpty ? nil : queryItems
            
            guard let finalURL = newComponents.url else {
                return nil
            }
            print(finalURL)
            return finalURL
        }
    }
}
