import Foundation

protocol HomeViewFeatures {
    var state: HomeViewState { get }
    var events: [Event]? { get }
    
    func getEvents()
}
