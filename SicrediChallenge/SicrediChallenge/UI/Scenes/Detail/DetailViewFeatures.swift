import Foundation

protocol DetailViewFeatures {
    var state: DetailViewState { get }
    var event: EventDetail? { get }
    
    func getEventDetail()
    func sendCheckin(name: String, email: String)
}
