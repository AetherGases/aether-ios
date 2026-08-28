import Security
import Foundation

protocol AuthTokenStorageProtocol {
    func saveEmail(_ email: String)
    func getEmail() -> String?
    func clearEmail()
    @discardableResult func saveToken(_ token: String) -> Bool
    func getToken() -> String?
    func clearToken()
    func isAuthenticated() -> Bool
    @discardableResult func saveRefreshToken(_ token: String) -> Bool
    func getRefreshToken() -> String?
    func clearRefreshToken()
    func logout()
}

class KeychainTokenStorage: AuthTokenStorageProtocol {
    private let service = "com.aether.auth"
    private let refreshAccount = "refresh_token"
    private let accessAccount = "access_token"
    private let emailAccount = "account_email"

    // MARK: - Email
    func saveEmail(_ email: String) {
        save(email, forAccount: emailAccount)
    }

    func getEmail() -> String? {
        read(forAccount: emailAccount)
    }

    func clearEmail() {
        delete(forAccount: emailAccount)
    }

    // MARK: - Access token
    @discardableResult
    func saveToken(_ token: String) -> Bool {
        save(token, forAccount: accessAccount)
    }

    func getToken() -> String? {
        read(forAccount: accessAccount)
    }

    func clearToken() {
        delete(forAccount: accessAccount)
    }

    func isAuthenticated() -> Bool {
        getToken() != nil
    }

    // MARK: - Refresh token
    @discardableResult
    func saveRefreshToken(_ token: String) -> Bool {
        save(token, forAccount: refreshAccount)
    }

    func getRefreshToken() -> String? {
        read(forAccount: refreshAccount)
    }

    func clearRefreshToken() {
        delete(forAccount: refreshAccount)
    }

    func logout() {
        clearToken()
        clearRefreshToken()
        clearEmail()
    }

    // MARK: - Keychain helpers
    @discardableResult
    private func save(_ value: String, forAccount account: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }

        delete(forAccount: account)

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ]

        let status = SecItemAdd(query as CFDictionary, nil)
        if status != errSecSuccess {
            // Sem uma falha silenciosa: se a escrita não for persistida, o app
            // não pode se comportar como se o usuário estivesse autenticado.
            assertionFailure("Keychain: falha ao salvar '\(account)' (status: \(status))")
        }
        return status == errSecSuccess
    }

    private func read(forAccount account: String) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        guard status == errSecSuccess,
              let data = result as? Data,
              let value = String(data: data, encoding: .utf8) else { return nil }

        return value
    }

    @discardableResult
    private func delete(forAccount account: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}
