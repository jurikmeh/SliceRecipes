// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v15)],
    products: [
        .library(name: "RecipeDetail", targets: ["RecipeDetail"]),
        .library(name: "RecipeListFeature", targets: ["RecipeListFeature"])
    ],
    dependencies: [
        .package(path: "Core")
    ],
    targets: [
        .target(
            name: "RecipeDetail",
            dependencies: [
                .product(name: "Domain", package: "Core"),
                .product(name: "Navigation", package: "Core")
            ]
        ),
        .target(
            name: "RecipeListFeature",
            dependencies: [
                .product(name: "Domain", package: "Core"),
                .product(name: "Error", package: "Core"),
                .product(name: "Network", package: "Core"),
                "RecipeDetail"
            ],
            resources: [
                .process("Resources")
            ]
        )
    ]
)
