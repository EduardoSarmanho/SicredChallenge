import Foundation
import RestService

protocol EventsFeatures {
    
    @discardableResult
    func getListOfEvents(callback: @escaping (GetEventsResponse) -> Void) -> RestDataTask?
}
