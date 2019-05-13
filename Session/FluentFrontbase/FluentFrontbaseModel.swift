/// A Frontbase database model.
/// See `Fluent.Model`.
public protocol FrontbaseModel: _FrontbaseModel where Self.ID == Int {
    /// This SQLite Model's unique identifier.
    var id: ID? { get set }
}

/// Base Frontbase model protocol.
public protocol _FrontbaseModel: FrontbaseTable, Model where Self.Database == FrontbaseDatabase { }

/// A Frontbase database model.
/// See `Fluent.Model`.
public protocol FrontbaseUUIDModel: _FrontbaseModel where Self.ID == UUID {
    /// This Frontbase Model's unique identifier.
    var id: UUID? { get set }
}

/// A Frontbase database model.
/// See `Fluent.Model`.
public protocol FrontbaseStringModel: _FrontbaseModel where Self.ID == String {
    /// This Frontbase Model's unique identifier.
    var id: String? { get set }
}

extension FrontbaseUUIDModel {
    /// See `Model`
    public static var idKey: IDKey { return \.id }
}

extension FrontbaseModel {
    /// See `Model`
    public static var idKey: IDKey { return \.id }
}

