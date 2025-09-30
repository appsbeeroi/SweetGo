import SwiftUI

@main
struct SweetGoApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Task {
                        await AppNotificationService.instance.askForPermission()
                    }
                }
        }
    }
}
