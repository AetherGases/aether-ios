enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case unauthenticatedUser
    case unexpectedError
    case unexpectedStatus(Int)
}
