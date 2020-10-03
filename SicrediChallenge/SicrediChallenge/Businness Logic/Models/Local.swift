import CoreLocation

public struct Local {
    
    let state: String?
    let city: String?
    let street: String?
    let number: String?

    init(clPlacemark: CLPlacemark) {
        
        self.state = clPlacemark.administrativeArea
        self.city = clPlacemark.locality
        self.street = clPlacemark.thoroughfare
        self.number = clPlacemark.subThoroughfare
    }
}
