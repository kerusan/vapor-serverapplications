import Fluent
import Frontbase


extension FrontbaseDatabase: JoinSupporting {
    /// See `JoinSupporting`.
    public typealias QueryJoin = FrontbaseJoin
    
    /// See `JoinSupporting`.
    public typealias QueryJoinMethod = FrontbaseJoinMethod

    public static var queryJoinMethodDefault: QueryJoinMethod { get { return GenericSQLJoinMethod.default} }


    public static func queryJoin(_ method: QueryJoinMethod, base: QueryField, joined: QueryField) -> QueryJoin {
        // TODO
    }
    
    static public func queryJoinApply(_ join: QueryJoin, to query: inout Query) {
        // TODO
    }

}
