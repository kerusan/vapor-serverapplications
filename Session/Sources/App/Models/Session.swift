import FluentSQLite
import Vapor

public let expiresInterval = 30.0

/// A single entry of a Session list.
final class Session: SQLiteModel {
    /// The unique identifier for this `Session`.
    var id: Int?
    /// A representation describing what this `Session` entails.
    var representation: String
    /// A date describing when this `Session` expires.
    var expires: Date

    /// Creates a new `Session`.
    init(id: Int? = nil, representation: String) {
        self.id = id
        self.representation = representation
        self.expires = Date()
        self.expires.addTimeInterval(expiresInterval)
    }
    
    func updateExpires() {
        self.expires = Date()
        self.expires.addTimeInterval(expiresInterval)
    }
}

/// Allows `Session` to be used as a dynamic migration.
extension Session: Migration { }

/// Allows `Session` to be encoded to and decoded from HTTP messages.
extension Session: Content { }

/// Allows `Session` to be used as a dynamic parameter in route definitions.
extension Session: Parameter { }
