import Fluent
import Frontbase

/// A Frontbase database migration.
/// See `Fluent.Migration`.

//public protocol FrontbaseMigration: Migration where Self.Database == FrontbaseDatabase { }
extension FrontbaseDatabase: MigrationSupporting {
    public static func prepareMigrationMetadata(on conn: FrontbaseConnection) -> EventLoopFuture<Void> {
        // TODO
        return conn.future()
    }
    
    public static func revertMigrationMetadata(on conn: FrontbaseConnection) -> EventLoopFuture<Void> {
        // TODO
        return conn.future()
    }
}


