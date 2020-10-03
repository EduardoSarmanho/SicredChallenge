import Foundation

public enum GetCheckinResponse {
    
    case success(Data?)
    case failure(ServiceError, Data?)
}
