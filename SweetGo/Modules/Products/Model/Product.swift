import Foundation

struct Product: Identifiable, Codable, Equatable {
    let id: UUID
    let type: ProductType
    var quantity: Int
    var isOrdered = false 
    
    var totalPrice: Double {
        type.price * Double(quantity)
    }
    
    init(isMock: Bool) {
        self.id = UUID()
        self.type = isMock ? .candies : .gifts
        self.quantity = 1
    }
    
    init(type: ProductType, quantity: Int) {
        self.id = UUID()
        self.type = type
        self.quantity = quantity
    }
}
