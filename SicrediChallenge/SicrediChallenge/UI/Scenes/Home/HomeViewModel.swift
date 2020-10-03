import UIFlow
import Foundation

class HomeViewModel: ModelObservable, HomeViewFeatures {
   
    var events: [Event]? = []
    
    var observers: [ModelObserver] = []
    
    var state: HomeViewState = .started
    
    var invalid_data_message: String?
   
    let eventModule: EventsFeatures!
    
    init(eventModule: EventsFeatures) {
        self.eventModule = eventModule
    }
}

// MARK: - Services
extension HomeViewModel {
    func getEvents() {
        state = .loading
        notifyObservers()
        
        eventModule.getListOfEvents(callback: { response in
            switch response {
                
            case .failure:
                self.state = .requestFailed
                self.notifyObservers()
                
            case .success(let events, _):
                self.events = events
                self.state = .requestSucceded
                self.notifyObservers()
            }
        })
    }
}
