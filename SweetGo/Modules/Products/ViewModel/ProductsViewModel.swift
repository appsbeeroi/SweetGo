import Foundation

final class ProductsViewModel: ObservableObject {
    
    private let udManager = UDManager.shared
    
    @Published var isCloseNavigation = false
    
    @Published private(set) var products: [Product] = []
    
    func loadProducts() {
        Task { [weak self] in
            guard let self else { return }
            
            let products = await udManager.fetch([Product].self, for: .products) ?? []
            
            await MainActor.run {
                self.products = products.filter { !$0.isOrdered }
            }
        }
    }
    
    func save(_ tupple: (type: ProductType, quantity: Int)) {
        Task { [weak self] in
            guard let self else { return }
            
            var products = await self.udManager.fetch([Product].self, for: .products) ?? []
            let newProduct = Product(type: tupple.type, quantity: tupple.quantity)
            
            products.append(newProduct)
            
            await self.udManager.save(products, for: .products)
            
            await MainActor.run {
                self.products.append(newProduct)
                self.isCloseNavigation = true
            }
        }
    }
    
    func save(_ products: [Product]) {
        Task { [weak self] in
            guard let self else { return }
            
            var udProducts = await self.udManager.fetch([Product].self, for: .products) ?? []
            
            for product in products {
                if let index = udProducts.firstIndex(where: { $0.id == product.id }) {
                    udProducts[index] = product
                }
            }
            
            for (index, product) in udProducts.enumerated() {
                if !products.contains(product) {
                    udProducts.remove(at: index)
                }
            }
            
            await self.udManager.save(udProducts, for: .products)
            
            await MainActor.run {
                self.products = products
                self.isCloseNavigation = true 
            }
        }
    }
    
    func save(_ order: Order) {
        Task { [weak self] in
            guard let self else { return }
            
            async let products = await self.udManager.fetch([Product].self, for: .products) ?? []
            async let orders = await self.udManager.fetch([Order].self, for: .order) ?? []
            
            let result = await (products: products, orders: orders)
            var newOrders = result.orders
            
            newOrders.append(order)
            
            await self.udManager.save(newOrders, for: .order)
            
            var newProducts = result.products
            
            for product in order.products {
                var newProduct = product
                newProduct.isOrdered = true
                
                if let index = newProducts.firstIndex(where: { $0.id == newProduct.id }) {
                    newProducts[index] = newProduct
                } else {
                    newProducts.append(newProduct)
                }
            }
            
            await self.udManager.save(newProducts, for: .products)
            
            await MainActor.run {
                self.isCloseNavigation = true
            }
        }
    }
}
