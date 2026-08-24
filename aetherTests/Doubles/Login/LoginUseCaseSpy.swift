// aetherTests/Doubles/Login/LoginUseCaseSpy.swift

import Foundation
@testable import aether

/// Dupla de teste para `LoginUseCaseProtocol`. Sempre "loga com sucesso";
/// use `stubbedError` se algum teste precisar simular falha do use case.
final class LoginUseCaseSpy: LoginUseCaseProtocol {
    private(set) var executeCallCount = 0
    private(set) var lastEmail: String?
    private(set) var lastPassword: String?

    var stubbedError: Error?

    func execute(email: String, password: String) async throws -> AuthResponseDTO {
        executeCallCount += 1
        lastEmail = email
        lastPassword = password

        if let stubbedError {
            throw stubbedError
        }

        return AuthResponseDTO(
            email: email,
            accessToken: "access-token",
            authenticated: true,
            created: Date(),
            expiration: Date(),
            refreshToken: "refresh-token"
        )
    }
}
