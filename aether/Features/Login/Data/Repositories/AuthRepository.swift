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
    
    func refresh(email: String, token: String) async throws -> AuthResponseDTO {
        let body = RefreshRequestDTO(email: email, token: token)
        
        return try await networkClient.request(
            endpoint: AuthAPI.refresh(email: email).path,
            method: AuthAPI.refresh(email: email).method,
            body: body
        )
    }
}
