import UIFlow
import RestService

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    let restService: RestService!
    
    // MARK: - Initializer
    init(navigation: UINavigationController, restService: RestService) {
        self.restService = restService
        super.init(navigation: navigation)
    }
    
    // MARK: - Coordinator
    override func start(animated: Bool) {
        
        let homeCoordinator = EventsCoordinator(navigation: navigation, restService: restService)
        start(child: homeCoordinator, animated: true)
        
        if let currentViewController = navigation.viewControllers.last {
            navigation.setViewControllers([currentViewController], animated: false)
        }
    }
}
