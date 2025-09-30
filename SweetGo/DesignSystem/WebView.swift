import SwiftUI

struct WebView: View {
    
    let url: URL
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button("Back") {
                    action()
                }
            }
            .frame(height: 50)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            .background(.black)
            
            Divider()
            
            WebViewRepresentable(url: url)
        }
    }
}

