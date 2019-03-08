import Vapor
import Fluent

/// Controls basic CRUD operations on `Todo`s.
final class LoginController {

    /// Returns login `User`s.
    func logedInUser(_ request: Request) throws -> Future<User> {
        let users = try request.parameters.next(User.self)

        // Do loginstuff
        return users
    }

    /// Returns login `User`s.
    func login(_ request: Request) throws -> Future<HTTPStatus> {
        //let users = User.query(on: req).all()

        //let userKey = try request.parameters.next(String.self)
        let result = try request.content.decode(Dictionary<String, String>.self).flatMap { userDict -> EventLoopFuture<HTTPStatus> in

            let userKey = userDict["userKey"]!
            guard userDict.count > 0 else {
                return request.future(HTTPStatus(statusCode: 400))
            }

            let result = User.query(on: request).filter(\User.firstName, .equal, userKey).all().map { (users) -> HTTPStatus in
                guard users.count > 0 else {
                    return HTTPStatus(statusCode: 404)
                }

                let user = users[0]
                let response = Response(using: request)

                print(user)
                print(response)

                if !users.isEmpty {
                    return HTTPStatus(statusCode: 200)
                } else {
                    return HTTPStatus(statusCode: 400)
                }
            }
            return result
        }
        return result
    }
}
