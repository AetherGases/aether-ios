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
        let welcomeMessage: String
        let isAuthenticated: Bool
    }
}
