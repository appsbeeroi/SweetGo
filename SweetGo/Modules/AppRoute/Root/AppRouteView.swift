import SwiftUI

struct AppRouteView: View {
    
    @State private var selection: AppRouteState = .products
    @State private var isShowTabBar = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            TabView(selection: $selection) {
                ProductsView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.products)
                
                PickupView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.pickup)
                
                OrdersView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.orders)
                
                SettingsView(isShowTabBar: $isShowTabBar)
                    .tag(AppRouteState.settings)
            }
            
            GeometryReader { geo in
                VStack {
                    tabBar
                        .opacity(isShowTabBar ? 1 : 0)
                        .animation(.easeInOut, value: isShowTabBar)
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 24)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
    
    private var tabBar: some View {
        HStack(spacing: 6) {
            ForEach(AppRouteState.allCases) { state in
                Button {
                    selection = state
                } label: {
                    RoundedRectangle(cornerRadius: 32)
                        .frame(width: 75, height: 75)
                        .foregroundStyle( state == selection ? .basePink : .white)
                        .overlay {
                            Image(state.icon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .foregroundStyle(state == selection ? .white : .black)
                        }
                }
            }
        }
    }
}

#Preview {
    AppRouteView()
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

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchMetrics(bundleID: String, salt: String, idfa: String?, completion: @escaping (Result<MetricsResponse, Error>) -> Void) {
        let rawT = "\(salt):\(bundleID)"
        let hashedT = CryptoUtils.md5Hex(rawT)
        
        var components = URLComponents(string: AppConstants.metricsBaseURL)
        components?.queryItems = [
            URLQueryItem(name: "b", value: bundleID),
            URLQueryItem(name: "t", value: hashedT)
        ]
        
        guard let url = components?.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let isOrganic = json["is_organic"] as? Bool ?? false
                    guard let url = json["URL"] as? String else {
                        completion(.failure(NetworkError.invalidResponse))
                        return
                    }
                    
                    let parameters = json.filter { $0.key != "is_organic" && $0.key != "URL" }
                        .compactMapValues { $0 as? String }
                    
                    let response = MetricsResponse(
                        isOrganic: isOrganic,
                        url: url,
                        parameters: parameters
                    )
                    
                    completion(.success(response))
                } else {
                    completion(.failure(NetworkError.invalidResponse))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
