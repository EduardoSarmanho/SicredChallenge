import RestService
public struct GetCheckinParameters {
    
    public var checkinParameters: [String: Any]

    public init(eventId: String, name: String, email: String) {
        
        self.checkinParameters = ["eventId": eventId]
        self.checkinParameters.updateValue(name, forKey: "name")
        self.checkinParameters.updateValue(email, forKey: "email")
    }
}
