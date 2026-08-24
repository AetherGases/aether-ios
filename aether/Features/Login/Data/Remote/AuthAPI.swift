enum AuthAPI {
    case login
    case refresh(email: String)
    case logout
    
    var path: String {
        switch self {
        case .login: return "/api/auth/login"
        case .refresh(let email): return "/api/auth/refresh/\(email)"
        case .logout: return "/api/auth/logout"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .logout, .refresh: return .post
        }
    }
}
