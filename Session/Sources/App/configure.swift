import Vapor
import FluentFrontbase

public let expiresInterval = 30.0

extension DatabaseIdentifier {
    static var uaf: DatabaseIdentifier<FrontbaseDatabase> {
        return .init("UAF")
    }
    
    static var free: DatabaseIdentifier<FrontbaseDatabase> {
        return .init("FREE")
    }
}

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentFrontbaseProvider())
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)
    
    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    Session.defaultDatabase = .uaf

    // Configure a Frontbase database
    let uaf = FrontbaseDatabase(name: "UAF", onHost: "localhost", username: "_system", password: "")
    let free = FrontbaseDatabase(name: "UAF", onHost: "localhost", username: "_system", password: "")

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: uaf, as: .uaf)
    databases.enableLogging(on: .uaf)
    databases.add(database: free, as: .free)
    databases.enableLogging(on: .free)
    services.register(databases)

    
    // Configure migrations
    //var migrations = MigrationConfig()
    //migrations.add(model: Session.self, database: .uaf)
    //services.register(migrations)
}
