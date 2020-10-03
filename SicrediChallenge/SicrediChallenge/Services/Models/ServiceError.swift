import Foundation

public struct ServiceError {
    
    var message: String?
    var code: Int?
    
    init(message: String? = nil, code: Int? = nil) {
        self.message = message
        self.code = code
    }
    
    init(data: [String: Any]) {
        
        self.message = data["message"] as? String
        self.code = data["code"] as? Int
    }
}
