import Foundation

struct AuthResponseDTO: Codable {
    let email: String
    let accessToken: String
    let authenticated: Bool
    let created: Date
    let expiration: Date
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case accessToken = "access_token"
        case authenticated, created, expiration
        case refreshToken = "refresh_token"
    }
}
