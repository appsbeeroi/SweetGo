import SwiftUI

enum ProductType: Identifiable, CaseIterable, Codable {
    var id: Self { self }
    
    case candies
    case chocolates
    case cookies
    case gifts
    
    var category: String {
        switch self {
            case .candies:
                "Candies"
            case .chocolates:
                "Chocolate"
            case .cookies:
                "Cookies"
            case .gifts:
                "Gifts"
        }
    }
    
    var title: String {
        switch self {
            case .candies:
                "Assorted Wrapped Candies"
            case .chocolates:
                "Chocolate Bar"
            case .cookies:
                "Chocolate Chip Cookies"
            case .gifts:
                "Gift Box of Sweets"
        }
    }
    
    var description: String {
        switch self {
            case .candies:
                "Colorful assorted candies individually wrapped in shiny foil."
            case .chocolates:
                "Classic milk chocolate bar broken into pieces."
            case .cookies:
                "Soft cookies with rich chocolate chips."
            case .gifts:
                "Festive box filled with assorted candies and chocolates."
        }
    }
    
    var price: Double {
        switch self {
            case .candies:
                2.50
            case .chocolates:
                3.50
            case .cookies:
                2.80
            case .gifts:
                12.00
        }
    }
    
    var unit: String {
        switch self {
            case .candies:
                "pack"
            case .chocolates:
                "bar"
            case .cookies:
                "pack"
            case .gifts:
                "box"
        }
    }
    
    var icon: ImageResource {
        switch self {
            case .candies:
                    .Images.Products.candies
            case .chocolates:
                    .Images.Products.chocolate
            case .cookies:
                    .Images.Products.cookies
            case .gifts:
                    .Images.Products.gift
        }
    }
}


