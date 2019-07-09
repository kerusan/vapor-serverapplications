// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Session",
    products: [
        .library(name: "Session", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        //.package(url: "https://github.com/vapor/vapor.git", .branch("3.0.0")),

        // 🇩🇰 A database module for the Frontbase database.
        .package(url: "ssh+git://git.oops.se/var/OopsGit/Vapor/Frontbase.git", from: "1.0.0"),
        
        // 🇩🇰 A database module for the Frontbase database.
        .package(url: "ssh+git://git.oops.se/var/OopsGit/Vapor/FluentFrontbase.git", from: "1.0.0"),
        
        // Swift Fluent
        .package(url: "https://github.com/vapor/fluent.git", from: "3.0.0"),
        //.package(url: "https://github.com/vapor/fluent.git", .branch("master")),

        // Swift FluentKit
        //.package(url: "https://github.com/vapor/fluent-kit.git", .branch("master")),
        //.package(url: "https://github.com/vapor/fluent-kit.git", .branch("master")),

        // ☁️ A database module for the SQLite database.
        //.package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        //.package(url: "https://github.com/vapor/fluent-sqlite.git", .branch("master")),
        
        // Swift SQLKit
        //.package(url: "https://github.com/vapor/sql.git", .branch("master")),
        .package(url: "https://github.com/vapor/sql.git", from: "2.0.0"),
        
        // Swift DatabaseKit
        //.package(url: "https://github.com/vapor/database-kit.git", from: "1.0.0")
        //.package(url: "https://github.com/vapor/database-kit.git", .branch("master")),

        //.package(url: "https://github.com/vapor/nio-kit.git", .branch("master")),
        
    ],
    targets: [
        .target(name: "App", dependencies: [ "Vapor", "Frontbase", "Fluent", "SQL"]),
        //.target(name: "App", dependencies: ["Vapor", "Frontbase", "Fluent", "FluentKit", "FluentSQLite", "SQLKit", "DatabaseKit"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
