// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "quest",
    dependencies: [
        // .package(url: "https://github.com/sunlubo/SwiftFFmpeg.git", from: "1.0.0"),
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
        .package(url: "https://github.com/pvieito/PythonKit.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "quest",
            dependencies: [
                "PythonKit",
                "SwiftyGPIO"
            ]
        )
    ]
)