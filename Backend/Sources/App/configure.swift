import FluentSQLite
import Vapor

extension DatabaseIdentifier {
    static var uaf: DatabaseIdentifier<SQLiteDatabase> {
        return .init("UAF")
    }
}

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentSQLiteProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
    //let uaf = try SQLiteDatabase(storage: .memory)
    let uaf = try SQLiteDatabase(storage: .file(path: "/Users/kerusan/Developer/Database/SQLite/UAF.sqlite"))

    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    databases.add(database: uaf, as: .uaf)
    databases.enableLogging(on: .uaf)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .uaf)
    services.register(migrations)
}
