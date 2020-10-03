import UIFlow
import Foundation

class HomeViewModel: ModelObservable, HomeViewFeatures {
    
    var observers: [ModelObserver] = []
    
    var state: HomeViewState = .started
    
    var invalid_data_message: String?
}

// MARK: - Features
extension HomeViewModel {
}

// MARK: - Services
extension HomeViewModel {
    
}
