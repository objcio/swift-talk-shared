// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-talk-shared",
    products: [
        .library(
            name: "Model",
            targets: ["Model"]),
        .library(
            name: "ViewHelpers",
            targets: ["ViewHelpers"]),
    ],
    dependencies: [],
    targets: [
	    .target(name: "Model", dependencies: []),
	    .target(name: "ViewHelpers", dependencies: []),
        .testTarget(
            name: "swift-talk-sharedTests",
            dependencies: []),
    ]
)
