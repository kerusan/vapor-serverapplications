import Vapor

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
        //let conn = req.databaseConnection(to: .uaf)

        let users = User.query(on: request).filter(\User.firstName, .equal, "xxx").all().map() { (users)-> HTTPStatus in
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
        return users
    }
}
