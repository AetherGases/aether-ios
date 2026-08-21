import Foundation

protocol LoginInteractorProtocol {
    func login(request: Login.Request)
}

class LoginInteractor: LoginInteractorProtocol {
    private let loginUseCase: LoginUseCaseProtocol
    private let presenter: LoginPresenterProtocol
    
    init(loginUseCase: LoginUseCaseProtocol, presenter: LoginPresenterProtocol) {
        self.loginUseCase = loginUseCase
        self.presenter = presenter
    }
    
    func login(request: Login.Request) {
        do {
            try validate(request: request)
        } catch let error as Login.ValidationError {
            presenter.presentLoginFailure(error: error)
            return
        } catch {
            presenter.presentLoginFailure(error: error)
            return
        }
        
        Task {
            do {
                let response = try await loginUseCase.execute(
                    email: request.email,
                    password: request.password
                )
                self.presenter.presentLoginSuccess(
                    response: Login.Response(
                        email: response.email,
                        authenticated: response.authenticated
                    )
                )
            } catch {
                self.presenter.presentLoginFailure(error: error)
            }
        }
    }
    
    private func validate(request: Login.Request) throws {
        guard !request.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { throw Login.ValidationError.emptyEmail }
        
        guard isValidEmail(request.email)
        else { throw Login.ValidationError.invalidEmailFormat }
        
        guard !request.password.isEmpty
        else { throw Login.ValidationError.emptyPassword }
        
        guard hasNumberPassword(request.password)
        else { throw Login.ValidationError.noNumberPassword }
        
        guard hasSpecialCharacterPassword(request.password)
        else { throw Login.ValidationError.noSpecialCharacterPassword }
        
        guard hasCapitalCharacterPassword(request.password)
        else { throw Login.ValidationError.noUpperPassword }
        
        guard hasMinorCharacterPassword(request.password)
        else { throw Login.ValidationError.noLowerPassword }
        
        guard isShortPassword(request.password)
        else { throw Login.ValidationError.shortPassword }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    private func isShortPassword(_ password: String) -> Bool {
        return password.count >= 8
    }
    
    private func hasNumberPassword(_ password: String) -> Bool {
        let regex = ".*[0-9].*"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    private func hasSpecialCharacterPassword(_ password: String) -> Bool {
        let regex = ".*[@#\\$%&\\(\\)\\-\\+=\\{\\}\\[\\]<>;,\\*].*"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    private func hasCapitalCharacterPassword(_ password: String) -> Bool {
        let regex = ".*[A-Z].*"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
    
    private func hasMinorCharacterPassword(_ password: String) -> Bool {
        let regex = ".*[a-z].*"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
}
