import SwiftUI

struct SplashScreen: View {
    
    @Binding var isOnboardingEnded: Bool
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image(.Images.colorBG)
                .baseResizable()
            
            VStack(spacing: 20) {
                Image(.Images.Splash.splash)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("SweetsGO")
                    .font(.impact(with: 61))
                    .foregroundStyle(.sgDarkRed)
            }
            .opacity(isAnimating ? 1 : 0)
            .animation(.easeIn(duration: 3), value: isAnimating)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isAnimating = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: .splashTransition)) { _ in
                withAnimation {
                    isOnboardingEnded = true
                }
            }
        }
    }
}

#Preview {
    SplashScreen(isOnboardingEnded: .constant(false))
}
