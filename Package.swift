// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "storage",
    products: [
        .library(
            name: "Storage",
            targets: ["Storage"]
        ),
    ],
    targets: [
        .target(
            name: "Storage",
            path: "Sources"
        ),
        .testTarget(
            name: "StorageTests",
            dependencies: ["Storage"],
            path: "Tests"
        ),
    ]
)
