
import Vapor
import Frontbase

/// Registers and boots Frontbase services.
public final class FluentFrontbaseProvider: Provider {
    /// Create a new Frontbase provider.
    public init() { }
    
    /// See Provider.register
    public func register(_ services: inout Services) throws {
        try services.register(FluentFrontbaseProvider())
        services.register { container -> FrontbaseDatabase in
            // TODO: Fix filebased storage
            //let storage = try container.make(FrontbaseStorage.self)
            return FrontbaseDatabase(name: "UAF", onHost: "localhost", username: "_system", password: "")
        }
        services.register(KeyedCache.self) { container -> FrontbaseCache in
            let pool = try container.connectionPool(to: .frontbase)
            return .init(pool: pool)
        }
    }
    
    /// See Provider.boot
    public func didBoot(_ container: Container) throws -> Future<Void> {
        return .done(on: container)
    }
}

public typealias FrontbaseCache = DatabaseKeyedCache<ConfiguredDatabase<FrontbaseDatabase>>
extension FrontbaseDatabase: KeyedCacheSupporting { }
extension FrontbaseDatabase: Service { }




/*
 /// Registers and boots Frontbase services.
public final class FluentFrontbaseProvider: Provider {
    /// Create a new Frontbase provider.
    public init() { }
    
    /// See Provider.register
    public func register(_ services: inout Services) throws {
        try services.register(FluentProvider())
        services.register { container -> FrontbaseDatabase in
            let _ = try container.make(FrontbaseStorage.self)
            return FrontbaseDatabase (name: "UAF", onHost: "localhost", username: "_system", password: "")
        }
        /*
         services.register(KeyedCache.self) { container -> FrontbaseCache in
         let pool = try container.connectionPool(to: .uaf)
         return .init(pool: pool)
         }*/
    }
    
    /// See Provider.boot
    public func didBoot(_ container: Container) throws -> Future<Void> {
        return .done(on: container)
    }
}

//public typealias FrontbaseCache = DatabaseKeyedCache<ConfiguredDatabase<FrontbaseDatabase>>

 extension FrontbaseDatabase: KeyedCacheSupporting {
 public static func keyedCacheGet<D>(_ key: String, as decodable: D.Type, on conn: FrontbaseConnection) throws -> EventLoopFuture<D?> where D : Decodable {
 
 }
 
 public static func keyedCacheSet<E>(_ key: String, to encodable: E, on conn: FrontbaseConnection) throws -> EventLoopFuture<Void> where E : Encodable {
 
 }
 
 public static func keyedCacheRemove(_ key: String, on conn: FrontbaseConnection) throws -> EventLoopFuture<Void> {
 
 }
 }

extension FrontbaseDatabase: Service { }

 */
