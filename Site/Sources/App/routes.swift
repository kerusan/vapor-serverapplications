import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Launches Boplats page
    let noController = NoController()
    router.get { req -> Future<View> in
        return try noController.noroute(request: req)
    }
    
    router.get("test") { req -> Future<View> in
        return try noController.test(request: req)
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
