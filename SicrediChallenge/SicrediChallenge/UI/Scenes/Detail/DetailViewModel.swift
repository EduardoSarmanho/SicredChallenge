import UIFlow
import Foundation

class DetailViewModel: ModelObservable, DetailViewFeatures {
    func getEventDetail() {
        
    }
    
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
    
}
