import Foundation

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case unauthenticatedUser
    case unexpectedError
    case unexpectedStatus(Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            "URL inválida"
        case .invalidResponse:
            "Resposta inválida do request!"
        case .decodingError:
            "Erro de decodificação!"
        case .unauthenticatedUser:
            "Usuário não autenticado!"
        case .unexpectedError:
            "Erro inesperado!"
        case .unexpectedStatus:
            "Status de resposta inesperado!"
        }
    }
}
