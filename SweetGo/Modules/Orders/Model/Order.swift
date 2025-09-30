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
    
    init() {
        self.id = UUID()
        self.productType = .candies
        self.products = [Product(isMock: true)]
        self.point = PickupPoint.mocks.first!
        self.status = .created
    }
    
    init(productType: ProductType, products: [Product]) {
        self.id = UUID()
        self.productType = productType
        self.products = products
        self.status = .created
    }
}
