protocol LoginInteractorProtocol {
    func login(request: Login.Request)
}

class LoginInteractor: LoginInteractorProtocol {
    private let loginUseCase: LoginUseCaseProtocol
    private let presenter: LoginPresenterProtocol
    
    init(loginUseCase: LoginUseCaseProtocol, presenter: LoginPresenterProtocol) {
        self.loginUseCase = loginUseCase
        self.presenter = presenter
    }
    
    func login(request: Login.Request) {
        Task {
            do {
                let response = try await loginUseCase.execute(
                    email: request.email,
                    password: request.password
                )
                self.presenter.presentLoginSuccess(
                    response: Login.Response(
                        email: response.email,
                        authenticated: response.authenticated
                    )
                )
            } catch {
                self.presenter.presentLoginFailure(error: error)
            }
        }
    }
}
