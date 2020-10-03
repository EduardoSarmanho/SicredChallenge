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
    func getEventDetail() {
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
