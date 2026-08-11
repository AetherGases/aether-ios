import UIKit

class DependencyContainer {
    
    private lazy var networkClient: NetworkClientProtocol = {
        NetworkClient(baseURL: "http://localhost:3000")
    }()
       
    private lazy var tokenStorage: AuthTokenStorageProtocol = {
        KeychainTokenStorage()
    }()
    
    func makeNetworkClient() -> NetworkClientProtocol {
        return networkClient
    }
    
    func makeTokenStorage() -> AuthTokenStorageProtocol {
        return tokenStorage
    }
    
    func makeAuthRepository() -> AuthRepositoryProtocol {
        return AuthRepository(networkClient: networkClient)
    }
    
    func makeLoginUseCase() -> LoginUseCaseProtocol {
        return LoginUseCase(repository: makeAuthRepository(), tokenStorage: tokenStorage)
    }
    
    func makeLoginInteractor(view: LoginViewControllerProtocol) -> LoginInteractorProtocol {
        return LoginInteractor(loginUseCase: makeLoginUseCase(), presenter: makeLoginPresenter(view: view))
    }
    
    func makeLoginPresenter(view: LoginViewControllerProtocol) -> LoginPresenterProtocol {
        return LoginPresenter(view: view)
    }
    
    func makeLoginViewController() -> LoginViewController {
        return LoginViewController()
    }
    
    func makeLoginRouter(navigationController: UINavigationController) -> LoginRouterProtocol {
        return LoginRouter(navigationController: navigationController)
    }
}
