import Foundation

class NetworkClient: NetworkClientProtocol {
    
    private let baseURL: String
    
    init(baseURL: String = "https://mock.aether.dev/api") {
        self.baseURL = baseURL
    }
    
    func request<T>(
        endpoint: String,
        method: HTTPMethod,
        body: (any Encodable)?
    ) async throws -> T where T: Decodable {
        
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let body = body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.unexpectedStatus(httpResponse.statusCode)
        }

        return try JSONDecoder().decode(T.self, from: data)
        
    }
}
