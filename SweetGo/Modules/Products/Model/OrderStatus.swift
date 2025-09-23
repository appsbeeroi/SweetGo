import UIKit

enum OrderStatus: Codable {
    case created
    case received
    
    var title: String {
        switch self {
            case .created:
                "Created"
            case .received:
                "Received"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .created:
                    .Images.Pickup.created
            case .received:
                    .Images.Pickup.received
        }
    }
}
