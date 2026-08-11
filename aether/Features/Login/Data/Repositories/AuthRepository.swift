class AuthRepository: AuthRepositoryProtocol {
    private let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    func login(email: String, password: String) async throws -> AuthResponseDTO {
        let body = LoginRequestDTO(email: email, password: password)
        
        return try await networkClient.request(
            endpoint: AuthAPI.login.path,
            method: AuthAPI.login.method,
            body: body
        )
    }
}
