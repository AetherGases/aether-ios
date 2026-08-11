import UIKit

protocol LoginRouterProtocol {
    func routeToHome()
}

class LoginRouter: LoginRouterProtocol {
    private weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func routeToHome() {
        // TODO: - Navegar pra Home
    }
}
