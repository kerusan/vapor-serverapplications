import FluentFrontbase
import Vapor

/// A single entry of a User list.
final class User: FrontbaseModel {
    /// A title describing what this `User` entails.
    var id: Int?
    var firstName: String
    var lastName: String
    var password: String

    /// Creates a new `User`.
    init(id: Int? = nil, firstName: String, lastName: String, password: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.password = password
    }
}

/// Allows `User` to be used as a dynamic migration.
extension User: Migration { }

/// Allows `User` to be encoded to and decoded from HTTP messages.
extension User: Content { }

/// Allows `User` to be used as a dynamic parameter in route definitions.
extension User: Parameter { }
