import UIKit

protocol LoginRouterProtocol {
    func routeToHome()
}

class LoginRouter: LoginRouterProtocol {
    private weak var navigationController: UINavigationController?
    private let container: DependencyContainer
    
    init(navigationController: UINavigationController?, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func routeToHome() {
        guard let navigationController = navigationController else { return }
        
        let homeVC = container.makeHomeViewController(navigationController: navigationController)
        
        // Substitui a pilha — Login não deve voltar pra Home
        navigationController.setViewControllers([homeVC], animated: true)
    }
}
