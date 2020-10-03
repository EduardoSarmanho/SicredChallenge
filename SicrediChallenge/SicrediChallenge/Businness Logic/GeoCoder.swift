import Foundation
import CoreLocation

class GeoCoder {
    
    public static func getLocal(latitude: Double, longitude: Double, completion: @escaping (Local?) -> Void) {
        
        let clGeoCoder = CLGeocoder.init()
        
        clGeoCoder.reverseGeocodeLocation(CLLocation.init(latitude: latitude, longitude: longitude)) {
            (locals, error) in
            
            guard let clPlacemark = locals?.first, error == nil else {
                completion(nil)
                return
            }
             
            completion(Local(clPlacemark: clPlacemark))
        }
    }
}
