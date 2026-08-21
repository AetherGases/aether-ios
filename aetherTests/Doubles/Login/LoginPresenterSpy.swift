// aetherTests/Doubles/Login/LoginPresenterSpy.swift

@testable import aether

/// Dupla de teste para `LoginPresenterProtocol`. Captura a última chamada
/// recebida para que os testes possam inspecionar o que o Interactor decidiu apresentar.
final class LoginPresenterSpy: LoginPresenterProtocol {
    private(set) var failureError: Error?
    private(set) var successResponse: Login.Response?

    func presentLoginSuccess(response: Login.Response) {
        successResponse = response
    }

    func presentLoginFailure(error: Error) {
        failureError = error
    }
}
