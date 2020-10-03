import Foundation
import RestService

protocol EventsFeatures {
    
    @discardableResult
    func getListOfEvents(callback: @escaping (GetEventsResponse) -> Void) -> RestDataTask?
    
    @discardableResult
    func getEventDetail(event id: Int, callback: @escaping (GetEventDetailResponse) -> Void) -> RestDataTask?
    
    @discardableResult
    func postCheckin(parameters: GetCheckinParameters, callback: @escaping (GetCheckinResponse) -> Void) -> RestDataTask?
}
