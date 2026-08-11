import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let container: DependencyContainer
    
    init(window: UIWindow, container: DependencyContainer) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let tokenStorage = container.makeTokenStorage()
                
        if tokenStorage.isAuthenticated() {
            // TODO
        } else {
            showLogin()
        }
    }
    
    func showLogin() {
        let navigationController = UINavigationController()
        
        let loginViewController = container.makeLoginViewController()
        let interactor = container.makeLoginInteractor(view: loginViewController)
        let router = container.makeLoginRouter(navigationController: navigationController)
        
        loginViewController.configure(interactor: interactor, router: router)
        
        navigationController.viewControllers = [loginViewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
