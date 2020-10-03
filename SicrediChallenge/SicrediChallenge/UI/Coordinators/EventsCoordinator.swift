import UIFlow
import RestService

class EventsCoordinator: Coordinator {
    
    // MARK: - Initializer
    override init(navigation: UINavigationController) {
        super.init(navigation: navigation)
    }
    
    // MARK: - Coordinator
    override func start(animated: Bool) {
        navigateToHome(animated: true)
    }
}

// MARK: - HomeViewNavigation
extension EventsCoordinator: HomeViewNavigation {
    func navigateToHome(animated: Bool) {
        guard let scene = HomeViewController.instantiate() else { return }
        scene.coordinator = self
        scene.viewModel = HomeViewModel()
        
        navigation.pushViewController(scene, animated: animated)
    }
    
    func goToDetails(_ sender: HomeViewController, event id: Int) {
    }
}
