import Foundation
import RestService

struct RestServiceFactory {
    
    func getProdRestService(sessionDelegate: URLSessionDelegate? = nil) -> RestService {
        
        var session = URLSession.shared
        
        if let sessionDelegate = sessionDelegate {
            session = URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: nil)
        }
        
        return RestService(session: session, scheme: .http, host: "5f5a8f24d44d640016169133.mockapi.io")
    }
    
    func getDevRestService(sessionDelegate: URLSessionDelegate? = nil) -> RestService {
        
        var session = URLSession.shared
        
        if let sessionDelegate = sessionDelegate {
            session = URLSession(configuration: .default, delegate: sessionDelegate, delegateQueue: nil)
        }
        
        return RestService(session: session, scheme: .http, host: "5f5a8f24d44d640016169133.mockapi.io")
    }
}
