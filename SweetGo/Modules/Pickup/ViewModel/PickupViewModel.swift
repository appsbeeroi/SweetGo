import Foundation
import Combine

final class PickupViewModel: ObservableObject {
    
    private let udManager = UDManager.shared
    
    @Published var searchedText = ""
    @Published var isCloseNavigation = false
    
    @Published private(set) var favoritesPoints: [PickupPoint] = []
    @Published private(set) var filteredPoints: [PickupPoint] = []
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        observeText()
    }
    
    func loadFavorites() {
        Task { [weak self] in
            guard let self else { return }
          
            let favoritesIDs = await self.udManager.fetch([Int].self, for: .favorites) ?? []
            
            await MainActor.run {
                self.favoritesPoints = PickupPoint.mocks.filter { favoritesIDs.contains($0.id) }
                self.isCloseNavigation = true
            }
        }
    }
    
    func saveFavorite(_ point: PickupPoint) {
        Task { [weak self] in
            guard let self else { return }
            
            var favoritesIDs = await self.udManager.fetch([Int].self, for: .favorites) ?? []
            
            if let index = favoritesIDs.firstIndex(where: { $0 == point.id }) {
                favoritesIDs.remove(at: index)
            } else {
                favoritesIDs.append(point.id)
            }
            
            await self.udManager.save(favoritesIDs, for: .favorites)
            
            await MainActor.run {
                if let index = self.favoritesPoints.firstIndex(where: { $0.id == point.id }) {
                    self.favoritesPoints.remove(at: index)
                } else {
                    self.favoritesPoints.append(point)
                }
                
                self.isCloseNavigation = true
            }
        }
    }
    
    private func observeText() {
        $searchedText
            .sink { [weak self] text in
                guard let self,
                text != "" else {
                    self?.filteredPoints = PickupPoint.mocks
                    return
                }
                
                self.filteredPoints = PickupPoint.mocks.filter {
                    $0.address.contains(text) ||
                    $0.name.contains(text) ||
                    $0.comments.contains(text)
                }
            }
            .store(in: &cancellable)
    }
}
