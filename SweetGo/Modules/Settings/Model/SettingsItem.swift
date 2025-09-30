enum SettingsItem: Identifiable, CaseIterable {
    var id: Self { self }
    
    case notification
    case privacy
    case developer
    
    var title: String {
        switch self {
            case .notification:
                "Notification"
            case .privacy:
                "Privacy Policy"
            case .developer:
                "About the developer"
        }
    }
    
    var linkString: String {
        switch self {
            case .privacy:
                "https://sites.google.com/view/sweetsgo/privacy-policy"
            case .developer:
                "https://sites.google.com/view/sweetsgo/home"
            default:
                ""
        }
    }
}
