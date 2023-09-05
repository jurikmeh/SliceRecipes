// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "Domain", targets: ["Domain"]),
        .library(name: "Error", targets: ["Error"]),
        .library(name: "Network", targets: ["Network"]),
        .library(name: "Utils", targets: ["Utils"]),
        .library(name: "DiLib", targets: ["DiLib"]),
        .library(name: "Navigation", targets: ["Navigation"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Domain"),
        .target(name: "Error"),
        .target(name: "Utils"),
        .target(name: "DiLib"),
        .target(
            name: "Navigation",
            dependencies: [
                "Error",
                "DiLib"
            ]
        ),
        .target(
            name: "Network",
            dependencies: [
                "Error",
                "Utils"
            ]
        )
    ]
)
