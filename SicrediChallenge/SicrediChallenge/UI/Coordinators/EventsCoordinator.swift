import UIFlow
import RestService

class EventsCoordinator: Coordinator {
    
    // MARK: - Properties
    let restService: RestService!
    
    // MARK: - Initializer
    init(navigation: UINavigationController, restService: RestService) {
       
        self.restService = restService
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
        let eventModule = EventsModule(service: restService)
        scene.viewModel = HomeViewModel(eventModule: eventModule)
        
        navigation.pushViewController(scene, animated: animated)
    }
    
    func goToDetails(_ sender: HomeViewController, event id: Int) {
        navigateToDetail(animated: true, event: id)
    }
}

// MARK: - DetailViewNavigation
extension EventsCoordinator: DetailViewNavigation {
    func backToHome(animated: Bool) {
        back(animated: animated, toRoot: false)
    }
    
    func navigateToDetail(animated: Bool, event id: Int) {
        guard let scene = DetailViewController.instantiate() else { return }
        scene.coordinator = self
        let eventModule = EventsModule(service: restService)
        scene.viewModel = DetailViewModel(eventModule: eventModule, event: id)
        
        navigation.pushViewController(scene, animated: animated)
    }
}
