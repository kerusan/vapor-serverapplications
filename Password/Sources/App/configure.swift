import Vapor
import Frontbase

public let expiresInterval = 30.0

extension DatabaseIdentifier {
    static var pwned: DatabaseIdentifier<FrontbaseDatabase> {
        return .init("pwnedpwds")
    }
}

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    services.register(Databases.self)

    // Configure a Frontbase database
    let pwned = FrontbaseDatabase(name: "pwnedpwds", onHost: "db.bop.oops.se", username: "_system", password: "")
    
    // Register the configured Frontbase database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: pwned, as: .pwned)
    databases.enableLogging(on: .pwned)
    services.register(databases)
}
