import Foundation
import CryptoKit

struct PasswordHelper {
    static func hashPassword(_ password: String) -> String {
        let salt = "random_salt" // You should use a unique salt for each password
        let inputData = Data((password + salt).utf8)
        let hashed = SHA256.hash(data: inputData)
        return hashed.compactMap { String(format: "%02x", $0) }.joined()
    }

    static func verifyPassword(_ password: String, hash: String) -> Bool {
        return hashPassword(password) == hash
    }
}
