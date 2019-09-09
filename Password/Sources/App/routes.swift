import Vapor
import Frontbase
import Crypto

struct PwnedPwd: Codable {
    let hash: String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    router.get("api", "password") { req in
        return "Pwned Passwords!"
    }
    
    // Example of configuring a controller
    router.get("api", "password", String.parameter) { req -> Future<String> in
        let password = try req.parameters.next(String.self)
        let digest = try SHA1.hash(password)
        let hashString = digest.hexEncodedString()

        return req.withNewConnection(to:.pwned) { conn in
            let result = conn.raw("SELECT \"hash\" FROM \"pwd160\" WHERE \"hash\" = x'\(hashString)'").first().map { result -> String in
                if result == nil {
                    return "NO"
                } else {
                    return "YES"
                }
            }
            return result
        }
    }
    

}


// 7c4a8d09ca3762af61e59520943dc26494f8941b
