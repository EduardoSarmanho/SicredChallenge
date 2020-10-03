import UIFlow
import RestService
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    let factory = RestServiceFactory()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var restService: RestService = factory.getProdRestService()
        
        #if DEBUG
        restService = factory.getDevRestService()
        #endif
        
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        coordinator = AppCoordinator(navigation: navigation, restService: restService)
        coordinator?.start(animated: false)
        
        IQKeyboardManager.shared.enable = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
        return true
    }
}

