import CoreLocation

public struct Local {
    
    let country: String?
    let state: String?
    let city: String?
    let street: String?
    let number: String?

    init(clPlacemark: CLPlacemark) {
        
        self.country = clPlacemark.country
        self.state = clPlacemark.administrativeArea
        self.city = clPlacemark.locality
        self.street = clPlacemark.thoroughfare
        self.number = clPlacemark.subThoroughfare
    }
}
