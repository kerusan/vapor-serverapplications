// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Session",
    products: [
        .library(name: "Session", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        // .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        // 🇩🇰 A database module for the Frontbase database.
        .package(url: "ssh+git://git.oops.se/var/OopsGit/Vapor/Frontbase.git", from: "1.0.0"),

        // Swift DatabaseKit
        .package(url: "https://github.com/vapor/database-kit.git", from: "1.3.3")
    ],
    targets: [
        .target(name: "App", dependencies: ["Frontbase", "DatabaseKit", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

