import UserNotifications
import UIKit

final class AppNotificationService {
    
    // MARK: - Singleton
    static let instance = AppNotificationService()
    private init() {}
    
    // MARK: - Permission State
    enum PermissionState {
        case allowed
        case rejected
        case undefined
    }
    
    // Текущий статус доступа
    var currentState: PermissionState {
        get async {
            let center = UNUserNotificationCenter.current()
            let settings = await center.notificationSettings()
            
            switch settings.authorizationStatus {
                case .authorized, .provisional:
                    return .allowed
                case .denied:
                    return .rejected
                case .notDetermined:
                    return .undefined
                default:
                    return .rejected
            }
        }
    }
    
    // MARK: - Request Permission
    @discardableResult
    func askForPermission() async -> Bool {
        let center = UNUserNotificationCenter.current()
        do {
            let granted = try await center.requestAuthorization(
                options: [.alert, .badge, .sound]
            )
            return granted
        } catch {
            return false
        }
    }
}
