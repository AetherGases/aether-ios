import Security
import Foundation

protocol AuthTokenStorageProtocol {
    func saveEmail(_ email: String)
    func getEmail() -> String?
    func clearEmail()
    func saveToken(_ token: String)
    func getToken() -> String?
    func clearToken()
    func isAuthenticated() -> Bool
    func saveRefreshToken(_ token: String)
    func getRefreshToken() -> String?
    func clearRefreshToken()
    func logout()
}

class KeychainTokenStorage: AuthTokenStorageProtocol {
    private let service = "com.aether.auth"
    private let refreshAccount = "refresh_token"
    private let accessAccount = "access_token"
    private let emailAccount = "account_email"
    
    func saveEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: emailAccount)
    }
    
    func getEmail() -> String? {
        UserDefaults.standard.string(forKey: emailAccount)
    }
    
    func clearEmail() {
        UserDefaults.standard.removeObject(forKey: emailAccount)
    }
    
    func saveToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        clearToken()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: accessAccount,
            kSecValueData as String: data
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: accessAccount,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let token = String(data: data, encoding: .utf8) else { return nil }
        
        return token
    }
    
    func clearToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: accessAccount
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    func isAuthenticated() -> Bool {
        return getToken() != nil
    }
    
    func saveRefreshToken(_ token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        clearRefreshToken()
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: refreshAccount,
            kSecValueData as String: data
        ]
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func getRefreshToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: refreshAccount,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let token = String(data: data, encoding: .utf8) else { return nil }
        
        return token
    }
    
    func clearRefreshToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: refreshAccount
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    func logout() {
        clearToken()
        clearRefreshToken()
    }
}
