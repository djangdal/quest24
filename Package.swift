// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Quest24",
    products: [
        .executable(name: "Quest24", targets: ["Quest24"]),
        .library(name: "Quest24Library", targets: ["Quest24Library"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3"),
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
        .package(url: "https://github.com/pvieito/PythonKit.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "Quest24",
            dependencies: ["Quest24Library"]
        ),
        .target(
            name: "Quest24Library",
            dependencies: [
                "PythonKit",
                "SwiftyGPIO",
                "SQLite"
            ]
        ),
        .testTarget(
            name: "Quest24Tests",
            dependencies: ["Quest24Library"]
        ),
    ]
)
