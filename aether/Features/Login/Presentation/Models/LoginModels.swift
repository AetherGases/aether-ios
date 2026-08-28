// aether/Features/Login/Presentation/Models/LoginModels.swift

enum Login {
    // View -> Interactor
    struct Request {
        let email: String
        let password: String
    }
    
    // Interactor -> Presenter
    struct Response {
        let email: String
        let authenticated: Bool
    }
    
    // Presenter -> View
    struct ViewModel {
        let message: String
        let isAuthenticated: Bool
    }
    
    enum ValidationError: Error, Equatable {
        case emptyEmail
        case invalidEmailFormat
        case emptyPassword
        case shortPassword
        case noNumberPassword
        case noSpecialCharacterPassword
        case noUpperPassword
        case noLowerPassword
    }
}
