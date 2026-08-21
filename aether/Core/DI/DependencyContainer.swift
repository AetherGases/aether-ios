import UIKit

class DependencyContainer {

    private lazy var tokenStorage: AuthTokenStorageProtocol = {
        KeychainTokenStorage()
    }()

    private lazy var networkClient: NetworkClient = {
        NetworkClient(baseURL: "http://localhost:3000", tokenStorage: tokenStorage)
    }()

    // Criado uma única vez e injetado de volta no NetworkClient logo abaixo,
    // para permitir que ele dispare o refresh automático em respostas 401
    // sem gerar um ciclo de inicialização entre as duas dependências.
    private lazy var authRepository: AuthRepositoryProtocol = {
        let repository = AuthRepository(networkClient: networkClient)
        networkClient.authRepository = repository
        return repository
    }()

    init() {
        // Força a resolução do authRepository (e a fiação acima) assim que o
        // container é criado, antes de qualquer request passar pelo NetworkClient.
        _ = authRepository
    }

    func makeNetworkClient() -> NetworkClientProtocol {
        return networkClient
    }

    func makeTokenStorage() -> AuthTokenStorageProtocol {
        return tokenStorage
    }

    func makeAuthRepository() -> AuthRepositoryProtocol {
        return authRepository
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
        return LoginRouter(navigationController: navigationController, container: self)
    }

    // MARK: - Home
    func makeHomeViewController(navigationController: UINavigationController) -> HomeViewController {
        let viewController = HomeViewController()
        let presenter = HomePresenter(view: viewController)
        let interactor = HomeInteractor(presenter: presenter, tokenStorage: tokenStorage)
        let router = HomeRouter(navigationController: navigationController, container: self)

        viewController.configure(interactor: interactor, router: router)

        return viewController
    }
}
