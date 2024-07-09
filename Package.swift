// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Quest24",
    products: [
        .executable(name: "Quest24", targets: ["Quest24"]),
        .library(name: "Quest24Library", targets: ["Quest24Library"]),
    ],
    dependencies: [
        // .package(url: "https://github.com/sunlubo/SwiftFFmpeg.git", from: "1.0.0"),
        .package(url: "https://github.com/uraimo/SwiftyGPIO.git", from: "1.0.0"),
<<<<<<< HEAD
        .package(url: "https://github.com/pvieito/PythonKit.git", .branch("master"))
//        .package(url: "https://github.com/djangdal/MFRC522.git", .branch("master"))
        // .package(path: "../MFRC522")
=======
        .package(url: "https://github.com/pvieito/PythonKit.git", .branch("master")),
        //        .package(url: "https://github.com/djangdal/MFRC522.git", .branch("master"))
        .package(path: "../MFRC522")
>>>>>>> 8d30c43213ed9e920a73390dc0e8044cf4d1c2de
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
                "SwiftyGPIO"
                // "MFRC522"
            ]
        ),
        .testTarget(
            name: "Quest24Tests",
            dependencies: ["Quest24Library"]
        ),
    ]
)
