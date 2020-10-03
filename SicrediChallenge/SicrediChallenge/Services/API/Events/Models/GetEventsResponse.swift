import Foundation

public enum GetEventsResponse {
    
    case success([Event], Data?)
    case failure(ServiceError, Data?)
}
