import Fluent
import Frontbase

extension FrontbaseDatabase: QuerySupporting {
    /// See `QuerySupporting`.
    public typealias Query = FrontbaseQuery
    
    /// See `QuerySupporting`.
    public typealias Output = [FrontbaseColumn: FrontbaseData]
    
    /// See `QuerySupporting`.
    public typealias QueryAction = FluentFrontbaseQueryStatement
    
    /// See `QuerySupporting`.
    public typealias QueryAggregate = String
    
    /// See `QuerySupporting`.
    public typealias QueryData = [String: FrontbaseExpression]
    
    /// See `QuerySupporting`.
    public typealias QueryField = FrontbaseColumnIdentifier
    
    /// See `QuerySupporting`.
    public typealias QueryFilterMethod = FrontbaseBinaryOperator
    
    /// See `QuerySupporting`.
    public typealias QueryFilterValue = FrontbaseExpression
    
    /// See `QuerySupporting`.
    public typealias QueryFilter = FrontbaseExpression
    
    /// See `QuerySupporting`.
    public typealias QueryFilterRelation = FrontbaseBinaryOperator
    
    /// See `QuerySupporting`.
    public typealias QueryKey = FrontbaseSelectExpression
    
    /// See `QuerySupporting`.
    public typealias QuerySort = FrontbaseOrderBy
    
    /// See `QuerySupporting`.
    public typealias QuerySortDirection = FrontbaseDirection
    
    
    
    /// See `QuerySupporting`.
    public static func queryExecute(_ fluent: Query, on conn: FrontbaseConnection, into handler: @escaping ([FrontbaseColumn : FrontbaseData], FrontbaseConnection) throws -> ()) -> Future<Void> {
        let query: FrontbaseQuery
        switch fluent.statement {
        case ._insert:
            var insert: FrontbaseInsert = .insert(fluent.table)
            var values: [FrontbaseExpression] = []
            fluent.values.forEach { row in
                // filter out all `NULL` values, no need to insert them since
                // they could override default values that we want to keep
                switch row.value {
                case ._literal(let literal):
                    switch literal {
                    case ._null: return
                    default: break
                    }
                default: break
                }
                insert.columns.append(.column(nil, .identifier(row.key)))
                values.append(row.value)
            }
            insert.values.append(values)
            query = .insert(insert)
        case ._select:
            var select: FrontbaseSelect = .select()
            select.columns = fluent.keys.isEmpty ? [.all] : fluent.keys
            select.tables = [fluent.table]
            select.joins = fluent.joins
            select.predicate = fluent.predicate
            select.orderBy = fluent.orderBy
            select.groupBy = fluent.groupBy
            select.limit = fluent.limit
            select.offset = fluent.offset
            query = .select(select)
        case ._update:
            var update: FrontbaseUpdate = .update(fluent.table)
            update.table = fluent.table
            update.values = fluent.values.map { val in
                return (.identifier(val.key), val.value)
            }
            update.predicate = fluent.predicate
            query = .update(update)
        case ._delete:
            var delete: FrontbaseDelete = .delete(fluent.table)
            delete.predicate = fluent.predicate
            query = .delete(delete)
        }
        return conn.query(query) { try handler($0, conn) }
    }
    
    /// See `QuerySupporting`.
    public static func modelEvent<M>(event: ModelEvent, model: M, on conn: FrontbaseConnection) -> EventLoopFuture<M> where FrontbaseDatabase == M.Database, M : Model {
        var copy = model
        switch event {
        case .willCreate:
            if M.ID.self is UUID.Type, copy.fluentID == nil {
                copy.fluentID = UUID() as? M.ID
            }
        case .didCreate:
            if let intType = M.ID.self as? Int64Initializable.Type, copy.fluentID == nil {
                copy.fluentID = conn.lastAutoincrementID.flatMap { intType.init($0) as? M.ID }
            }
        default: break
        }
        return conn.future(copy)
    }
}

internal protocol Int64Initializable {
    init(_ int64: Int64)
}

extension Int: Int64Initializable { }
extension UInt: Int64Initializable { }
extension Int64: Int64Initializable { }
extension UInt64: Int64Initializable { }
extension Int32: Int64Initializable { }
extension UInt32: Int64Initializable { }
