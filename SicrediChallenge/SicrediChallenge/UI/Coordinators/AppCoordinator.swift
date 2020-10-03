import UIFlow
import RestService

class AppCoordinator: Coordinator {
    
    // MARK: - Initializer
    override init(navigation: UINavigationController) {
        super.init(navigation: navigation)
    }
    
    // MARK: - Coordinator
    override func start(animated: Bool) {
        
        let homeCoordinator = EventsCoordinator(navigation: navigation)
        start(child: homeCoordinator, animated: true)
        
        if let currentViewController = navigation.viewControllers.last {
            navigation.setViewControllers([currentViewController], animated: false)
        }
    }
    
    func goBack(animated: Bool = true) {
        back(animated: true, toRoot: false)
    }
}
