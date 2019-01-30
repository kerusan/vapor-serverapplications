import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Launches Boplats page
    router.get { req -> Future<View> in
        let noController = NoController()
        return try noController.noroute(request: req)
    }

    // Shows login page and logins user
    let loginController = LoginController()
    router.get("login") { req -> Future<View> in
        return try loginController.login(request: req)
    }

    router.get("login", String.parameter) { req -> Future<View> in
        return try loginController.login(request: req)
    }

    // Shows search and does the search query
    let searchController = SearchController()
    router.get("search") { req -> Future<View> in
        return try searchController.search(request: req)
    }

    router.get("search", String.parameter) { req -> Future<View> in
        return try searchController.search(request: req)
    }
}
