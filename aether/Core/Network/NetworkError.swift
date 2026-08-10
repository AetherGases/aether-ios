enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case unexpectedStatus(Int)
}
