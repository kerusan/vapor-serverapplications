import Vapor
import Fluent

/// Controls basic CRUD operations on `User`s.
final class UserController {
    /// Returns a list of all `User`s.
    func all(_ request: Request) throws -> Future<[User]> {
        return User.query(on: request).all()
    }

    /// Fetches an indexed `User` to the database.
    func index(_ request: Request) throws -> Future<[User]> {
        let userId = try request.parameters.next(Int.self)
        let users = User.query(on: request).filter(\.id == userId).all()
        return users
    }

    func create(_ request: Request) throws -> Future<User> {
        return try request.content.decode(User.self).flatMap { user in
            return user.create(on: request)
        }
    }
    
    func update(_ request: Request) throws -> Future<User> {
        return try request.content.decode(User.self).flatMap { user in
            return user.update(on: request)
        }
    }
    
    /// Deletes a parameterized `User`.
    func delete(_ request: Request) throws -> Future<HTTPStatus> {
        return try request.parameters.next(User.self).flatMap { user in
            return user.delete(on: request)
        }.transform(to: .ok)
    }
}
