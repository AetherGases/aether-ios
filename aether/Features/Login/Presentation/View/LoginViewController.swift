import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func displayLoginSuccess(viewModel: Login.ViewModel)
    func displayLoginFailure(viewModel: Login.ViewModel)
}

class LoginViewController: UIViewController {
    private var interactor: LoginInteractorProtocol?
    private var router: LoginRouterProtocol?
    
    // MARK: - UI Elements
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(configuration: .filled())
    private let statusLabel = UILabel()
    
    // MARK: - Setup
    func configure(interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Login"
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        
        passwordTextField.placeholder = "Senha"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.isSecureTextEntry = true
        
        loginButton.setTitle("Entrar", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        statusLabel.text = "Faça login para continuar"
        statusLabel.textAlignment = .center
        
        // Layout (simples — depois melhoramos com constraints)
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton, statusLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    // MARK: - Actions
    @objc private func loginTapped() {
        let request = Login.Request(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? ""
        )
        interactor?.login(request: request)
    }
}

// MARK: - LoginViewControllerProtocol
extension LoginViewController: LoginViewControllerProtocol {
    func displayLoginSuccess(viewModel: Login.ViewModel) {
        DispatchQueue.main.async {
            self.statusLabel.text = viewModel.welcomeMessage
            self.router?.routeToHome()
        }
    }
    
    func displayLoginFailure(viewModel: Login.ViewModel) {
        DispatchQueue.main.async {
            self.statusLabel.text = viewModel.welcomeMessage
        }
    }
}
