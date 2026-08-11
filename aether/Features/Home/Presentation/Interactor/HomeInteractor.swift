// aether/Features/Home/Presentation/Interactor/HomeInteractor.swift

import Foundation

protocol HomeInteractorProtocol {
    func viewDidLoad()
    func logout()
}

class HomeInteractor: HomeInteractorProtocol {
    private let presenter: HomePresenterProtocol
    private let tokenStorage: AuthTokenStorageProtocol
    
    init(presenter: HomePresenterProtocol, tokenStorage: AuthTokenStorageProtocol) {
        self.presenter = presenter
        self.tokenStorage = tokenStorage
    }
    
    func viewDidLoad() {
        let email = tokenStorage.getEmail() ?? "Usuário"
        presenter.presentHome(response: Home.Response(email: email))
    }
    
    func logout() {
        tokenStorage.logout()
        presenter.presentLogout()
    }
}
