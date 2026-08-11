enum AuthAPI {
    case login
    case logout
    
    var path: String {
        switch self {
        case .login: return "/api/auth/login"
        case .logout: return "/api/auth/logout"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .logout: return .post
        }
    }
}
