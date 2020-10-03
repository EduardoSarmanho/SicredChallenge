import UIFlow
import Foundation

class DetailViewModel: ModelObservable, DetailViewFeatures {
    
    var observers: [ModelObserver] = []
    
    var state: DetailViewState = .started
    
    var event: EventDetail? = nil
    
    let eventModule: EventsFeatures!
    
    let eventId: Int
    
    init(eventModule: EventsFeatures, event id: Int) {
        self.eventModule = eventModule
        self.eventId = id
    }
}

// MARK: - Services
extension DetailViewModel {
    func sendCheckin(name: String, email: String) {
        self.state = .loading
        self.notifyObservers()
        
        eventModule.postCheckin(parameters: GetCheckinParameters(eventId: "\(eventId)", name: name, email: email), callback: { response in
            switch response {
            
            case .failure:
                self.state = .checkinFailed
                self.notifyObservers()
                
            case .success:
                self.state = .checkinSucceded
                self.notifyObservers()
            }
        })
    }

    func getEventDetail() {
        self.state = .loading
        self.notifyObservers()

        eventModule.getEventDetail(event: eventId, callback: { response in
            switch response {
            
            case .failure:
                self.state = .requestFailed
                self.notifyObservers()
                
            case .success(let event, _):
                self.event = event
                self.state = .requestSucceded
                self.notifyObservers()
            }
        })
    }
}
