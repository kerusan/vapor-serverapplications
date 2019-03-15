import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "There is something here!"
    }

    // Example of configuring a controller
    let userController = UserController()
    router.get("api", "users", use: userController.all)
    router.get("api", "users", Int.parameter, use: userController.index)
    router.post("api", "users", "create", use: userController.create)
    router.post("api", "users", use: userController.update)
    router.delete("api", "users", User.parameter, use: userController.delete)

    // Example of configuring a controller
    let loginController = LoginController()
    router.post("api", "login", use: loginController.login)
}
