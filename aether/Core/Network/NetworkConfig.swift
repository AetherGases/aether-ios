import Foundation

enum NetworkConfig {
    /// URL base usada pelo `NetworkClient`. Hoje resolve por build configuration;
    /// quando os ambientes reais de staging/produção existirem, substituir os
    /// placeholders abaixo (ou migrar para um `.xcconfig`/Info.plist por esquema).
    static var baseURL: String {
        #if DEBUG
        return "http://localhost:3000"
        #else
        return "https://api.aether.app" // TODO: apontar para o ambiente de produção real
        #endif
    }
}
