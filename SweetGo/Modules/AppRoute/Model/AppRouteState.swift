import SwiftUI

enum AppRouteState: Identifiable, CaseIterable {
    var id: Self { self }
    
    case products
    case pickup
    case orders
    case settings
    
    var icon: ImageResource {
        switch self {
            case .products:
                    .Images.TabBar.products
            case .pickup:
                    .Images.TabBar.pickup
            case .orders:
                    .Images.TabBar.orders
            case .settings:
                    .Images.TabBar.settings
        }
    }
}
