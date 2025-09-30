import SwiftUI


struct SettingsView: View {
    
    @AppStorage("AppStorageNotificationSwitchOn") var appStorageNotificationSwitchOn = false
    
    @Binding var isShowTabBar: Bool
    
    @State private var selectedItem: SettingsItem?
    @State private var isPushEnable = false
    @State private var isShowPushAlert = false
    
    var body: some View {
        ZStack {
            Image(.Images.BG)
                .baseResizable()
            
            VStack {
                navigation
                cells
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 20)
            
            if let selectedItem,
               let url = URL(string: selectedItem.linkString) {
                WebView(url: url) {
                    self.selectedItem = nil
                    self.isShowTabBar = true
                }
                .ignoresSafeArea(edges: [.bottom])
            }
        }
        .onChange(of: isPushEnable) { isEnable in
            if isEnable {
                Task {
                    switch await AppNotificationService.instance.currentState {
                        case .allowed:
                            isPushEnable = isEnable
                        case .rejected:
                            appStorageNotificationSwitchOn = true
                        case .undefined:
                            await AppNotificationService.instance.askForPermission()
                    }
                }
            } else {
                appStorageNotificationSwitchOn = false
            }
        }
        .alert("Notification permission wasn't allowed", isPresented: $isShowPushAlert) {
            Button("Yes") {
                openSettings()
            }
            
            Button("No") {
                isPushEnable = false
            }
        } message: {
            Text("Open app settings?")
        }
    }
    
    
    private var navigation: some View {
        Text("Settings")
            .font(.impact(with: 35))
            .foregroundStyle(.sgDarkRed)
    }
    
    private func openSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsURL) {
            UIApplication.shared.open(settingsURL)
        }
    }
    
    private var cells: some View {
        VStack(spacing: 8) {
            ForEach(SettingsItem.allCases) { item in
                SettingsCellView(item: item, pushEnabled: $isPushEnable) {
                    guard item != .notification else { return }
                    isShowTabBar = false
                    selectedItem = item
                }
            }
        }
        .padding(.top, 16)
        .padding(.horizontal, 35)
    }
}

#Preview {
    SettingsView(isShowTabBar: .constant(false))
}

import SwiftUI

struct SettingsCellView: View {
    
    var item: SettingsItem
    
    @Binding var pushEnabled: Bool
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(item.title)
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.sgDarkRed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                trailingView
            }
            .frame(height: 60)
            .padding(.horizontal, 23)
            .background(Color.white)
            .cornerRadius(20)
        }
    }
    
    @ViewBuilder
    private var trailingView: some View {
        switch item {
        case .notification:
            Toggle(isOn: $pushEnabled) {
                EmptyView()
            }
            .toggleStyle(SwitchToggleStyle(tint: .sgPink))
        default:
            Image(systemName: "chevron.right")
                .foregroundColor(.sgPink)
                .font(.system(size: 20, weight: .medium))
        }
    }
}
