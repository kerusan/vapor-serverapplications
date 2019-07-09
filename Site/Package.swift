// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Site",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.3.0"),

        // 🍃 An expressive, performant, and extensible templating language built for Swift.
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.2"),
        
        // 🌎 A HTTP client request/response package
        .package(url: "https://github.com/vapor/http.git", from: "3.2.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["Leaf", "Vapor", "HTTP"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
            
    ]
)

