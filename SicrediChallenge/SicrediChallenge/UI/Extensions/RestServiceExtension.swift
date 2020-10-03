import Foundation
import RestService

extension RestService {
    
    func getError(dict: [String: Any]) -> ServiceError? {
        guard let code = dict["statusCode"] as? Int,
              let message = dict["message"] as? String else {
            return nil
        }
        
        return ServiceError(message: message, code: code)
    }
    
    func getUnknownError() -> ServiceError {
        return ServiceError(message: "error.unknown".localized, code: 500)
    }
}
