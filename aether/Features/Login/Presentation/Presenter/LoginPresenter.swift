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
            message: "Bem-vindo, \(response.email)!",
            isAuthenticated: response.authenticated
        )
        view?.displayLoginSuccess(viewModel: viewModel)
    }
    
    func presentLoginFailure(error: Error) {
        let viewModel = Login.ViewModel(
            message: friendlyMessage(for: error),
            isAuthenticated: false
        )
        view?.displayLoginFailure(viewModel: viewModel)
    }
    
    private func friendlyMessage(for error: Error) -> String {
            switch error {
            case Login.ValidationError.emptyEmail:
                return "Informe seu email"
            case Login.ValidationError.invalidEmailFormat:
                return "Email em formato inválido"
            case Login.ValidationError.emptyPassword:
                return "Informe sua senha"
            case Login.ValidationError.shortPassword:
                return "Senha deve incluir 8 ou mais caracteres"
            case Login.ValidationError.noSpecialCharacterPassword:
                return "Senha deve incluir caractere especial"
            case Login.ValidationError.noUpperPassword:
                return "Senha deve incluir letra maiúscula"
            case Login.ValidationError.noLowerPassword:
                return "Senha deve incluir letra minúscula"
            case NetworkError.unexpectedStatus(401):
                return "Email ou senha incorretos"
            case NetworkError.unexpectedStatus(500...):
                return "Servidor indisponível. Tente novamente em instantes"
            case is NetworkError:
                return "Falha na comunicação. Verifique sua conexão"
            case let urlError as URLError where urlError.code == .notConnectedToInternet:
                return "Sem conexão com a internet"
            case is URLError:
                return "Sem conexão com o servidor. Verifique se o Mockoon está rodando"
            default:
                return "Algo deu errado. Tente novamente"
            }
        }
}
