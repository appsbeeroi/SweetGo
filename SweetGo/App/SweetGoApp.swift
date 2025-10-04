import SwiftUI

@main
struct SweetGoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            BlackWindow(rootView: ContentView(), remoteConfigKey: AppConstants.remoteConfigKey)
        }
    }
}

struct AppConstants {
    static let metricsBaseURL = "https://gsgowesst.com/app/metrics"
    static let salt = "KYX2IzbM8r8EM13ptinYHFA2wOGrcthZ"
    static let oneSignalAppID = "59ee568e-b218-48de-bc1e-1ccba419549b"
    static let userDefaultsKey = "sweet"
    static let remoteConfigStateKey = "sweetGo"
    static let remoteConfigKey = "isSweetGoEnable"
}

