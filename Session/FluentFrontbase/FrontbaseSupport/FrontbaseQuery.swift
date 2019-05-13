public enum FluentFrontbaseQueryStatement: FluentSQLQueryStatement {
    public typealias RawValue = FrontbaseData
    
    public static var insert: FluentFrontbaseQueryStatement { return ._insert }
    public static var select: FluentFrontbaseQueryStatement { return ._select }
    public static var update: FluentFrontbaseQueryStatement { return ._update }
    public static var delete: FluentFrontbaseQueryStatement { return ._delete }
    
    public var isInsert: Bool {
        switch self {
        case ._insert: return true
        default: return false
        }
    }
    
    case _insert
    case _select
    case _update
    case _delete
}

extension FrontbaseDatabase: FluentSQLQuery, QuerySupporting {
    
    public typealias Query = FrontbaseQuery
    public typealias Output = [FrontbaseColumn: FrontbaseData]
    public typealias QueryAction = FluentFrontbaseQueryStatement
    public typealias QueryAggregate = String
    public typealias QueryData = [String: FrontbaseExpression]
    public typealias QueryField = FrontbaseColumnIdentifier
    public typealias QueryFilterMethod = FrontbaseBinaryOperator
    public typealias QueryFilterValue = FrontbaseExpression
    public typealias QueryFilter = FrontbaseExpression
    public typealias QueryFilterRelation = FrontbaseBinaryOperator
    public typealias QueryKey = FrontbaseSelectExpression
    public typealias QuerySort = FrontbaseOrderBy
    public typealias QuerySortDirection = FrontbaseDirection
    
    
    public static func query(_ entity: String) -> FrontbaseQuery {
        <#code#>
    }
    
    public static func queryEntity(for query: FrontbaseQuery) -> String {
        <#code#>
    }
    
    public static func queryExecute(_ query: FrontbaseQuery, on conn: FrontbaseConnection, into handler: @escaping ([FrontbaseColumn : FrontbaseData], FrontbaseConnection) throws -> ()) -> EventLoopFuture<Void> {
        <#code#>
    }
    
    public static func queryDecode<D>(_ output: [FrontbaseColumn : FrontbaseData], entity: String, as decodable: D.Type, on conn: FrontbaseConnection) -> EventLoopFuture<D> where D : Decodable {
        <#code#>
    }
    
    public static func queryEncode<E>(_ encodable: E, entity: String) throws -> [String : FrontbaseExpression] where E : Encodable {
        <#code#>
    }
    
    public static func modelEvent<M>(event: ModelEvent, model: M, on conn: FrontbaseConnection) -> EventLoopFuture<M> where Self == M.Database, M : Model {
        <#code#>
    }
    
    public static func queryActionApply(_ action: FluentFrontbaseQueryStatement, to query: inout FrontbaseQuery) {
        <#code#>
    }
    
    public static var queryAggregateCount: String {
        <#code#>
    }
    
    public static var queryAggregateSum: String {
        <#code#>
    }
    
    public static var queryAggregateAverage: String {
        <#code#>
    }
    
    public static var queryAggregateMinimum: String {
        <#code#>
    }
    
    public static var queryAggregateMaximum: String {
        <#code#>
    }
    
    public static func queryDataSet<E>(_ field: FrontbaseColumnIdentifier, to data: E, on query: inout FrontbaseQuery) where E : Encodable {
        <#code#>
    }
    
    public static func queryDataApply(_ data: [String : FrontbaseExpression], to query: inout FrontbaseQuery) {
        <#code#>
    }
    
    public static func queryFilters(for query: FrontbaseQuery) -> [FrontbaseExpression] {
        <#code#>
    }
    
    public static func queryFilterApply(_ filter: FrontbaseExpression, to query: inout FrontbaseQuery) {
        <#code#>
    }
    
    public static func queryDefaultFilterRelation(_ relation: FrontbaseBinaryOperator, on: inout FrontbaseQuery) {
        <#code#>
    }
    
    public static func queryKeyApply(_ key: FrontbaseSelectExpression, to query: inout FrontbaseQuery) {
        <#code#>
    }
    
    public static func queryRangeApply(lower: Int, upper: Int?, to query: inout FrontbaseQuery) {
        <#code#>
    }
    
    public static func querySortApply(_ sort: FrontbaseOrderBy, to query: inout FrontbaseQuery) {
        <#code#>
    }

}

