class DependencyContainer {
    
    private lazy var networkClient: NetworkClientProtocol = {
        NetworkClient(baseURL: "http://localhost:3000/aether-api")
    }()
    
    func makeNetworkClient() -> NetworkClientProtocol {
        return networkClient
    }
}
