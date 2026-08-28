// aether/Features/Home/Presentation/Router/HomeRouter.swift

import UIKit

protocol HomeRouterProtocol {
    func routeToLogin()
}

class HomeRouter: HomeRouterProtocol {
    private weak var navigationController: UINavigationController?
    private let container: DependencyContainer
    
    init(navigationController: UINavigationController?, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func routeToLogin() {
        guard let navigationController = navigationController else { return }
        
        let loginVC = container.makeLoginViewController()
        let interactor = container.makeLoginInteractor(view: loginVC)
        let router = container.makeLoginRouter(navigationController: navigationController)
        
        loginVC.configure(interactor: interactor, router: router)
        
        // Substitui a pilha — Home não deve voltar pra Login
        navigationController.setViewControllers([loginVC], animated: true)
    }
}
