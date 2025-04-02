// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Latimove",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Latimove",
            targets: ["Latimove"]
        )
    ],
    targets: [
        .target(
            name: "Latimove",
            dependencies: []
        )
    ]
)
