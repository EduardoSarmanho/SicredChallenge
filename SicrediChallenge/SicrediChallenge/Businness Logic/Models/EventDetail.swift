public struct EventDetail: DataInit, Codable {
    
    var date: Int?
    var description: String?
    var image: String?
    var longitude: Double?
    var latitude: Double?
    var price: Double?
    var title: String?
    var id: String?
    var people: [People]?
    
    init(date: Int? = nil,
         description: String? = nil,
         image: String? = nil,
         longitude: Double? = nil,
         latitude: Double? = nil,
         price: Double? = nil,
         title: String? = nil,
         id: String? = nil,
         people: [People]? = nil) {
        
        self.date = date
        self.description = description
        self.image = image
        self.longitude = longitude
        self.latitude = latitude
        self.price = price
        self.title = title
        self.id = id
        self.people = people
        
    }
    
    init(data: [String: Any]) {
        
        self.date = data["date"] as? Int
        self.description = data["description"] as? String
        self.image = data["image"] as? String
        self.longitude = data["longitude"] as? Double
        self.latitude = data["latitude"] as? Double
        self.price = data["price"] as? Double
        self.title = data["title"] as? String
        self.id = data["id"] as? String
        if let people = data["people"] as? [[String:Any]]{
            self.people = people.map({ People(data: $0) })
        }
    }
}
