import Fluent
import Vapor
import Frontbase
import CFrontbaseSupport

public let expiresInterval = 30.0

/*
/// A single entry of a Session list.
final class Session: FluentFrontbaseModel {
    /// The unique identifier for this `Session`.
    var id: Int?
    /// A representation describing what this `Session` entails.
    var representation: String
    /// A date describing when this `Session` expires.
    var expires: Date

    /// Creates a new `Session`.
    init(id: Int? = nil, exp: Date?, representation: String) {
        self.id = id
        self.representation = hashString()
        if exp! < Date() {
            self.expires = Date()
            self.expires.addTimeInterval(expiresInterval)
        } else {
            self.expires = exp!
        }
    }

    func updateExpires() {
        self.expires = Date()
        self.expires.addTimeInterval(expiresInterval)
    }
}

func hashString() -> String {
    var stringRepresentation = "\(Date().hashValue)"
    
    if stringRepresentation.hasPrefix("-") {
        stringRepresentation.remove(at: stringRepresentation.startIndex)
    }
    return stringRepresentation
}

/// Allows `Session` to be used as a dynamic migration.
//extension Session: Migration { }

/// Allows `Session` to be encoded to and decoded from HTTP messages.
extension Session: Content { }

/// Allows `Session` to be used as a dynamic parameter in route definitions.
extension Session: Parameter {
    static func resolveParameter(_ parameter: String, on container: Container) throws -> Session {
        // TODO: Implement Maybe at other place
        return try next.respond(to: request)
    }
    
    static func resolveParameter(_ parameter: String, on container: Container) throws -> String {
        // TODO: Implement
        return try next.respond(to: request)
    }
    
    typealias ResolvedParameter = Session
}

 */

