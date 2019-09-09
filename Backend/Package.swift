// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "Backend",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        
        // 🔵 Swift ORM (queries, models, relations, etc) built on Frontbase.
        .package(url: "ssh+git://git.oops.se/var/OopsGit/Vapor/FluentFrontbase.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentFrontbase", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
