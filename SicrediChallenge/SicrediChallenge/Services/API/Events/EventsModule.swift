import Foundation
import RestService

struct EventsModule: EventsFeatures {
    
    let service: RestService!
    
    
    init(service: RestService) {
        self.service = service
    }
}

extension EventsModule {
    
    func getListOfEvents(callback: @escaping (GetEventsResponse) -> Void) -> RestDataTask? {
        
        return service.json(method: .get,
                            path: "/api/events",
                            interceptor: nil) { response in
            
            guard let arrayResponse = response.arrayValue() else {
                callback(.failure(self.service.getUnknownError(), response.data))
                return
            }
            guard let dictResponse = arrayResponse as? [[String: Any]] else {
                callback(.failure(self.service.getUnknownError(), response.data))
                return
            }
            let events = dictResponse.map({ Event(data: $0)})
            
            
            callback(.success(events, response.data))
        }
    }
}
