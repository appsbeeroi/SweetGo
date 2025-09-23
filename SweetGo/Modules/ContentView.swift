import SwiftUI

struct ContentView: View {
    
    @State private var isOnboardingEnded = false
    
    var body: some View {
        if isOnboardingEnded {
            AppRouteView()
        } else {
            SplashScreen(isOnboardingEnded: $isOnboardingEnded)
        }
    }
}

#Preview {
    ContentView()
}

