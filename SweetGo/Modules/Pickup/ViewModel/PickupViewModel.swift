import Foundation
import Combine

final class PickupViewModel: ObservableObject {
    
    private let udManager = UDManager.shared
    
    @Published var searchedText = ""
    @Published var isCloseNavigation = false
    
    @Published private(set) var favoritesPoints: [PickupPoint] = []
    @Published private(set) var filteredPoints: [PickupPoint] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        observeText()
    }
    
    func loadFavorites() {
        Task { [weak self] in
            guard let self else { return }
          
            let favoritesIDs = await self.udManager.fetch([Int].self, for: .favorites) ?? []
            
            await MainActor.run {
                self.favoritesPoints = PickupPoint.mocks.filter { favoritesIDs.contains($0.id) }
                self.isCloseNavigation = true
            }
        }
    }
    
    func saveFavorite(_ point: PickupPoint) {
        Task { [weak self] in
            guard let self else { return }
            
            var favoritesIDs = await self.udManager.fetch([Int].self, for: .favorites) ?? []
            
            if let index = favoritesIDs.firstIndex(where: { $0 == point.id }) {
                favoritesIDs.remove(at: index)
            } else {
                favoritesIDs.append(point.id)
            }
            
            await self.udManager.save(favoritesIDs, for: .favorites)
            
            await MainActor.run {
                if let index = self.favoritesPoints.firstIndex(where: { $0.id == point.id }) {
                    self.favoritesPoints.remove(at: index)
                } else {
                    self.favoritesPoints.append(point)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    private func observeText() {
        $searchedText
            .sink { [weak self] text in
                guard let self,
                text != "" else {
                    self?.filteredPoints = PickupPoint.mocks
                    return
                }
                
                self.filteredPoints = PickupPoint.mocks.filter {
                    $0.address.contains(text) ||
                    $0.name.contains(text) ||
                    $0.comments.contains(text)
                }
            }
            .store(in: &cancellable)
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

struct PrivacyView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    let ref: URL
    private let webView: WKWebView
    
    init(ref: URL) {
        self.ref = ref
        let configuration = WKWebViewConfiguration()
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: ref))
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        var parent: PrivacyView
        private var popupWebView: OverlayPrivacyWindowController?
        
        init(_ parent: PrivacyView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            configuration.websiteDataStore = WKWebsiteDataStore.default()
            let newOverlay = WKWebView(frame: parent.webView.bounds, configuration: configuration)
            newOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            newOverlay.navigationDelegate = self
            newOverlay.uiDelegate = self
            webView.addSubview(newOverlay)
            
            let viewController = OverlayPrivacyWindowController()
            viewController.overlayView = newOverlay
            popupWebView = viewController
            UIApplication.topMostController()?.present(viewController, animated: true)
            
            return newOverlay
        }
        
        func webViewDidClose(_ webView: WKWebView) {
            popupWebView?.dismiss(animated: true)
        }
    }
}
