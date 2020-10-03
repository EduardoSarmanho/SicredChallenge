public struct People: DataInit, Codable {
    
    var picture: String?
    var name: String?
    var eventId: String?
    var id: String?
   
    
    
    init(picture: String? = nil,
         name: String? = nil,
         eventId: String? = nil,
         id: String? = nil) {
        
        self.picture = picture
        self.name = name
        self.eventId = eventId
        self.id = id

    }
    
    init(data: [String: Any]) {
        
        self.picture = data["picture"] as? String
        self.name = data["name"] as? String
        self.eventId = data["eventId"] as? String
        self.id = data["id"] as? String
    }
}
