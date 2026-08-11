import Foundation

protocol LoginUseCaseProtocol {
    func execute(email: String, password: String) async throws -> AuthResponseDTO
}
