protocol AuthRepositoryProtocol {
    func login(email: String, password: String) async throws -> AuthResponseDTO
    func refresh(email: String, token: String) async throws -> AuthResponseDTO
}
