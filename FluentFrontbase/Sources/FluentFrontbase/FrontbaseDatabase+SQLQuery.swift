import Fluent
import Frontbase
import SQL

extension FrontbaseDatabase: FluentSQLQuery {
    public typealias AlterTable = FrontbaseAlterTable
    
    public typealias CreateIndex = FrontbaseCreateIndex
    
    public typealias CreateTable = FrontbaseCreateTable
    
    public typealias Delete = FrontbaseDelete
    
    public typealias DropIndex = FrontbaseDropIndex
    
    public typealias DropTable = FrontbaseDropTable
    
    public typealias Insert = FrontbaseInsert
    
    public typealias Select = FrontbaseSelect
    
    public typealias Update = FrontbaseUpdate
    
    public func serialize(_ binds: inout [Encodable]) -> String {
        // TODO: Fix
        return ""
    }
/*
    public static func alterTable(_ alterTable: FrontbaseAlterTable) -> Self {
        <#code#>
    }
    
    public static func createIndex(_ createIndex: FrontbaseCreateIndex) -> Self {
        <#code#>
    }
    
    public static func createTable(_ createTable: FrontbaseCreateTable) -> Self {
        <#code#>
    }
    
    public static func delete(_ delete: FrontbaseDelete) -> Self {
        <#code#>
    }
    
    public static func dropIndex(_ dropIndex: FrontbaseDropIndex) -> Self {
        <#code#>
    }
    
    public static func dropTable(_ dropTable: FrontbaseDropTable) -> Self {
        <#code#>
    }
    
    public static func insert(_ insert: FrontbaseInsert) -> Self {
        <#code#>
    }
    
    public static func select(_ select: FrontbaseSelect) -> Self {
        <#code#>
    }
    
    public static func update(_ update: FrontbaseUpdate) -> Self {
        <#code#>
    }
    
    public static func raw(_ sql: String, binds: [Encodable]) -> Self {
        <#code#>
    }
    */
}

