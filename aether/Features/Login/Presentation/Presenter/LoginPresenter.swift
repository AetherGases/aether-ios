import Foundation

protocol LoginPresenterProtocol {
    func presentLoginSuccess(response: Login.Response)
    func presentLoginFailure(error: Error)
}

class LoginPresenter: LoginPresenterProtocol {
    private weak var view: LoginViewControllerProtocol?
    
    init(view: LoginViewControllerProtocol) {
        self.view = view
    }
    
    func presentLoginSuccess(response: Login.Response) {
        let viewModel = Login.ViewModel(
            welcomeMessage: "Bem-vindo, \(response.email)!",
            isAuthenticated: response.authenticated
        )
        view?.displayLoginSuccess(viewModel: viewModel)
    }
    
    func presentLoginFailure(error: Error) {
        let viewModel = Login.ViewModel(
            welcomeMessage: "Erro: \(error.localizedDescription)",
            isAuthenticated: false
        )
        view?.displayLoginFailure(viewModel: viewModel)
    }
}
