import UIKit

protocol LoginViewControllerProtocol: AnyObject {
    func displayLoginSuccess(viewModel: Login.ViewModel)
    func displayLoginFailure(viewModel: Login.ViewModel)
}

class LoginViewController: UIViewController {
    private var interactor: LoginInteractorProtocol?
    private var router: LoginRouterProtocol?
    
    // MARK: - UI Elements
    private let titleLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton(type: .system)
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
        view.backgroundColor = AetherTheme.background
        
        titleLabel.text = "Bem-vindo ao Aether"
        titleLabel.textColor = AetherTheme.textPrimary
        titleLabel.font = AetherFont.titleLarge()
        titleLabel.textAlignment = .center
        
        emailTextField.placeholder = "Email"
        emailTextField.borderStyle = .roundedRect
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .emailAddress
        emailTextField.textColor = AetherTheme.textPrimary
        emailTextField.font = AetherFont.bodyMedium()
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [
                .foregroundColor: AetherTheme.inputPlaceholder,
                .font: AetherFont.bodyMedium()
            ]
        )
        
        passwordTextField.placeholder = "Senha"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.textContentType = .password
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = AetherTheme.textPrimary
        passwordTextField.font = AetherFont.bodyMedium()
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Senha",
            attributes: [
                .foregroundColor: AetherTheme.inputPlaceholder,
                .font: AetherFont.bodyMedium()
            ]
        )
        
        loginButton.setTitle("Entrar", for: .normal)
        loginButton.setTitleColor(AetherTheme.buttonText, for: .normal)
        loginButton.backgroundColor = AetherTheme.buttonBackground
        loginButton.titleLabel?.font = AetherFont.labelLarge(weight: .semiBold)
        loginButton.layer.cornerRadius = 8
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        
        statusLabel.text = "Faça login para continuar"
        statusLabel.textColor = AetherTheme.textSecondary
        statusLabel.font = AetherFont.bodyMedium()
        statusLabel.textAlignment = .center
        statusLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, emailTextField, passwordTextField, loginButton, statusLabel])
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
            self.statusLabel.text = viewModel.message
            self.router?.routeToHome()
        }
    }
    
    func displayLoginFailure(viewModel: Login.ViewModel) {
        DispatchQueue.main.async {
            self.statusLabel.textColor = AetherTheme.error
            self.statusLabel.text = viewModel.message
        }
    }
}
