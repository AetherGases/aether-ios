import Foundation

class LoginUseCase: LoginUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    private let tokenStorage: AuthTokenStorageProtocol
    
    init(repository: AuthRepositoryProtocol, tokenStorage: AuthTokenStorageProtocol) {
        self.repository = repository
        self.tokenStorage = tokenStorage
    }
    
    func execute(email: String, password: String) async throws -> AuthResponseDTO {
        let response = try await repository.login(email: email, password: password)
        
        tokenStorage.saveToken(response.accessToken)
        tokenStorage.saveRefreshToken(response.refreshToken)
        tokenStorage.saveEmail(email)
        
        return response
    }
}
