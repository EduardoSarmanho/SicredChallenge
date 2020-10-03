import Foundation
import RestService

struct EventsModule: EventsFeatures {

    let service: RestService!
    
    
    init(service: RestService) {
        self.service = service
    }
}

// MARK: - Get List Of Events
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

// MARK: - Get Event Detail
extension EventsModule {
    func getEventDetail(event id: Int, callback: @escaping (GetEventDetailResponse) -> Void) -> RestDataTask? {

        return service.json(method: .get,
                            path: "/api/events/\(id)",
                            interceptor: nil) { response in
            
            guard let dictResponse = response.dictionaryValue() else {
                callback(.failure(self.service.getUnknownError(), response.data))
                return
            }

            let event = EventDetail(data: dictResponse)
                    
            callback(.success(event, response.data))
        }
    }
}

// MARK: - Post Checkin
extension EventsModule {
    func postCheckin(parameters: GetCheckinParameters, callback: @escaping (GetCheckinResponse) -> Void) -> RestDataTask? {

        return service.json(method: .get,
                            path: "/api/checkin",
                            interceptor: nil) { response in
            
            guard let dictResponse = response.dictionaryValue() else {
                callback(.failure(self.service.getUnknownError(), response.data))
                return
            }
            
            if (dictResponse["code"] as? String) != "200" {
                callback(.failure(self.service.getUnknownError(), response.data))
                return
            }
            
            callback(.success(response.data))
        }
    }
}
