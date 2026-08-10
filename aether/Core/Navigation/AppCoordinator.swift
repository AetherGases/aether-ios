import UIKit

class AppCoordinator {
    private let window: UIWindow
    private let container: DependencyContainer
    
    init(window: UIWindow, container: DependencyContainer) {
        self.window = window
        self.container = container
    }
    
    func start() {
        let loginController = makeLoginViewController()
        let navigationController = UINavigationController(rootViewController: loginController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    private func makeLoginViewController() -> UIViewController {
        // TODO
        
        return UIViewController()
    }
}
