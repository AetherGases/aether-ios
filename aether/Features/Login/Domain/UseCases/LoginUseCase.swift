import Foundation

class LoginUseCase: LoginUseCaseProtocol {
    private let repository: AuthRepositoryProtocol
    private let tokenStorage: AuthTokenStorageProtocol
    
    init(repository: AuthRepositoryProtocol, tokenStorage: AuthTokenStorageProtocol) {
        self.repository = repository
        self.tokenStorage = tokenStorage
    }
    
    func execute(email: String, password: String) async throws -> AuthResponseDTO {
        
        guard !email.isEmpty && !password.isEmpty else {
            throw LoginError.emptyFields
        }
        
        let response = try await repository.login(email: email, password: password)
        
        tokenStorage.saveToken(response.accessToken)
                
        return response
    }
}

enum LoginError: Error {
    case emptyFields
}
