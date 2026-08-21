import Foundation

class NetworkClient: NetworkClientProtocol {
    
    private let baseURL: String
    private let tokenStorage: AuthTokenStorageProtocol?
    var authRepository: AuthRepositoryProtocol?
    
    init(baseURL: String = "http://localhost:3000", tokenStorage: AuthTokenStorageProtocol? = nil, authRepository: AuthRepositoryProtocol? = nil) {
        self.baseURL = baseURL
        self.tokenStorage = tokenStorage
        self.authRepository = authRepository
    }
    
    func request<T>(endpoint: String, method: HTTPMethod, body: (any Encodable)?) async throws -> T
    where T: Decodable {
        try await request(endpoint: endpoint, method: method, body: body, retriedAfterRefresh: false)
    }

    private func request<T>(
        endpoint: String,
        method: HTTPMethod,
        body: (any Encodable)?,
        retriedAfterRefresh: Bool
    ) async throws -> T where T: Decodable {

        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = tokenStorage?.getToken() {
            urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Só tenta renovar o token uma vez por chamada original — evita recursão
        // infinita caso o servidor continue devolvendo 401 após o refresh.
        if httpResponse.statusCode == 401,
           !retriedAfterRefresh,
           let email = tokenStorage?.getEmail(),
           let refreshToken = tokenStorage?.getRefreshToken() {

            let authResponse = try await authRepository?.refresh(email: email, token: refreshToken)

            guard let authResponse = authResponse else {
                throw NetworkError.unexpectedError
            }

            tokenStorage?.saveToken(authResponse.accessToken)
            tokenStorage?.saveRefreshToken(authResponse.refreshToken)

            return try await request(endpoint: endpoint, method: method, body: body, retriedAfterRefresh: true)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unexpectedStatus(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try decoder.decode(T.self, from: data)
        
    }
}
