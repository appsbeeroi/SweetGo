struct PickupPoint: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let address: String
    let schedule: String
    let comments: String
    let code: String
    var isFavorite: Bool = false 
}

extension PickupPoint {
    static let mocks: [PickupPoint] = [
        .init(
            id: 1,
            name: "SweetGo Central Hub",
            address: "Gedimino pr. 9, Vilnius 01103",
            schedule: "Mon-Fri 09:00-19:00, Sat-Sun 10:00-18:00",
            comments: "Main collection point, near the metro station",
            code: "SGC-01"
        ),
        .init(
            id: 2,
            name: "Choco Corner Outlet",
            address: "Pylimo g. 26, Vilnius 01135",
            schedule: "Mon-Sat 10:00-20:00, Sun 11:00-17:00",
            comments: "Small outlet, limited stock",
            code: "CCO-02"
        ),
        .init(
            id: 3,
            name: "Candy Express Point",
            address: "Vilniaus g. 262, Šiauliai 76306",
            schedule: "Mon-Fri 08:00-18:00",
            comments: "Fast pickup, near bus stop",
            code: "CEP-03"
        ),
        .init(
            id: 4,
            name: "Chocolate & Co. Depot",
            address: "J. Basanavičiaus g. 168, Šiauliai 76123",
            schedule: "Mon-Sun 09:00-21:00",
            comments: "Popular for weekend pickups",
            code: "CCD-04"
        ),
        .init(
            id: 5,
            name: "SweetStop Express",
            address: "Kanto g. 25, Šiauliai 44296",
            schedule: "Mon-Fri 10:00-19:00, Sat 10:00-16:00",
            comments: "Close to main shopping mall",
            code: "SSE-05"
        ),
        .init(
            id: 6,
            name: "Candy Lane Pickup",
            address: "Vokiečių g. 14, Kaunas 44255",
            schedule: "Mon-Fri 09:00-18:00, Sat 10:00-16:00",
            comments: "Quiet street, easy parking",
            code: "CLP-06"
        ),
        .init(
            id: 7,
            name: "Sweet Moments Hub",
            address: "Laisvės al. 77, Kaunas 44299",
            schedule: "Mon-Sun 09:00-20:00",
            comments: "Near central park, good for weekend pickups",
            code: "SMH-07"
        ),
        .init(
            id: 8,
            name: "Chocolate Dream Point",
            address: "Tilžės g. 123, Klaipėda 91234",
            schedule: "Mon-Fri 08:00-19:00, Sat 09:00-17:00",
            comments: "Close to train station",
            code: "CDP-08"
        ),
        .init(
            id: 9,
            name: "Sweet Treats Outlet",
            address: "Taikos pr. 45, Klaipėda 91245",
            schedule: "Mon-Sat 10:00-20:00, Sun 11:00-16:00",
            comments: "Small shop, cozy interior",
            code: "STO-09"
        ),
        .init(
            id: 10,
            name: "Candy Paradise Depot",
            address: "Ukmergės g. 56, Vilnius 09120",
            schedule: "Mon-Fri 09:00-19:00, Sat 10:00-16:00",
            comments: "Popular for students, near university",
            code: "CPD-10"
        )
    ]
}
