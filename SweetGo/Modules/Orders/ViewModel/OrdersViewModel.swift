import SwiftUI

final class OrdersViewModel: ObservableObject {

    private let udManager = UDManager.shared
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var orders: [Order] = []
    
    func loadOrders() {
        Task { [weak self] in
            guard let self else { return }
            
            let orders = await udManager.fetch([Order].self, for: .order) ?? []
            
            await MainActor.run {
                self.orders = orders
            }
        }
    }
    
    func save(_ order: Order) {
        Task { [weak self] in
            guard let self else { return }
            
            var orders = await self.udManager.fetch([Order].self, for: .order) ?? []
            
            if let index = orders.firstIndex(where: { $0.id == order.id }) {
                orders[index] = order
            } else {
                orders.append(order)
            }
            
            await self.udManager.save(orders, for: .order)
            
            await MainActor.run {
                if let index = self.orders.firstIndex(where: { $0.id == order.id }) {
                    self.orders.remove(at: index)
                } else {
                    self.orders.append(order)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
}
