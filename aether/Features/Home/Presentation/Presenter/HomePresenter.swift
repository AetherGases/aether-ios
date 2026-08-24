// aether/Features/Home/Presentation/Presenter/HomePresenter.swift

import Foundation

protocol HomePresenterProtocol: AnyObject {
    func presentHome(response: Home.Response)
    func presentLogout()
}

class HomePresenter: HomePresenterProtocol {
    private weak var view: HomeViewControllerProtocol?
    
    init(view: HomeViewControllerProtocol) {
        self.view = view
    }
    
    func presentHome(response: Home.Response) {
        let viewModel = Home.ViewModel(
            welcomeText: "Bem-vindo, \(response.email)!"
        )
        view?.displayHome(viewModel: viewModel)
    }
    
    func presentLogout() {
        view?.displayLogout()
    }
}
