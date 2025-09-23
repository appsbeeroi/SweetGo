import Foundation

final class UDManager {
    
    static let shared = UDManager()
    
    private let storage: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    private init(
        storage: UserDefaults = .standard,
        encoder: JSONEncoder = .init(),
        decoder: JSONDecoder = .init()
    ) {
        self.storage = storage
        self.encoder = encoder
        self.decoder = decoder
    }
    
    func save<T: Codable>(_ object: T, for key: UDKeys) async {
        do {
            let encodedData = try encoder.encode(object)
            storage.set(encodedData, forKey: key.rawValue)
        } catch {
            debugPrint("❌ Save error [\(T.self)] →", error.localizedDescription)
        }
    }
    
    func fetch<T: Codable>(_ type: T.Type, for key: UDKeys) async -> T? {
        guard let rawData = storage.data(forKey: key.rawValue) else {
            return nil
        }
        
        do {
            return try decoder.decode(T.self, from: rawData)
        } catch {
            debugPrint("❌ Fetch error [\(T.self)] →", error.localizedDescription)
            return nil
        }
    }
    
    func clear(_ key: UDKeys) {
        storage.removeObject(forKey: key.rawValue)
    }
}
