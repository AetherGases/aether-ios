// aether/Features/Home/Presentation/Models/HomeModels.swift

import Foundation

enum Home {
    // View -> Interactor
    struct Request {
        // Por enquanto vazio — Home não precisa de input pra carregar
    }
    
    // Interactor -> Presenter
    struct Response {
        let email: String
    }
    
    // Presenter -> View
    struct ViewModel {
        let welcomeText: String
    }
}
