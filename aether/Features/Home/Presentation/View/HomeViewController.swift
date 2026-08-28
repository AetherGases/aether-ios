// aether/Features/Home/Presentation/View/HomeViewController.swift

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func displayHome(viewModel: Home.ViewModel)
    func displayLogout()
}

class HomeViewController: UIViewController {
    private var interactor: HomeInteractorProtocol?
    private var router: HomeRouterProtocol?
    
    // MARK: - UI Elements
    private let welcomeLabel = UILabel()
    private let logoutButton = UIButton(configuration: .filled())
    
    // MARK: - Setup
    func configure(interactor: HomeInteractorProtocol, router: HomeRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        interactor?.viewDidLoad()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Home"
        
        navigationItem.hidesBackButton = true
        
        welcomeLabel.font = .systemFont(ofSize: 20, weight: .medium)
        welcomeLabel.textAlignment = .center
        
        logoutButton.setTitle("Sair", for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [welcomeLabel, logoutButton])
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24)
        ])
    }
    
    // MARK: - Actions
    @objc private func logoutTapped() {
        interactor?.logout()
    }
}

// MARK: - HomeViewControllerProtocol
extension HomeViewController: HomeViewControllerProtocol {
    func displayHome(viewModel: Home.ViewModel) {
        DispatchQueue.main.async {
            self.welcomeLabel.text = viewModel.welcomeText
        }
    }
    
    func displayLogout() {
        DispatchQueue.main.async {
            self.router?.routeToLogin()
        }
    }
}
