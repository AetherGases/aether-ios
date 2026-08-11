import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let container: DependencyContainer
    
    init(window: UIWindow, container: DependencyContainer) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        let loginController = makeLoginViewController(navigationController: navigationController)
        navigationController.viewControllers = [loginController]
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func makeLoginViewController(navigationController: UINavigationController) -> UIViewController {
        let viewController = container.makeLoginViewController()
        
        let interactor = container.makeLoginInteractor(view: viewController)
        let router = container.makeLoginRouter(navigationController: navigationController)
        
        viewController.configure(interactor: interactor, router: router)
        
        return viewController
    }
}
