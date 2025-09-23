import Foundation

struct Order: Identifiable, Equatable, Codable {
    let id: UUID
    var productType: ProductType
    var products: [Product]
    var point: PickupPoint?
    var status: OrderStatus
    
    var isLock: Bool {
        point == nil
    }
    
    init(productType: ProductType, products: [Product]) {
        self.id = UUID()
        self.productType = productType
        self.products = products
        self.status = .created
    }
}
