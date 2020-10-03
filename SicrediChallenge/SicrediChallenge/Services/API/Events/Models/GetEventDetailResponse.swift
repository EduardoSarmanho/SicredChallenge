import Foundation

public enum GetEventDetailResponse {
    
    case success(EventDetail, Data?)
    case failure(ServiceError, Data?)
}
