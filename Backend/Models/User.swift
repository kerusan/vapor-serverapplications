import FluentSQLite
import Vapor

/// A single entry of a Todo list.
final class User: SQLiteModel {
    typealias IDkey = Int
    
    
    /// The unique identifier for this `User`.
    static var idKey: IDKey { return \.id }

    /// A title describing what this `User` entails.
    var id: IDkey?
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
