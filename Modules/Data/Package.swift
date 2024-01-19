// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .macOS(.v12), .iOS(.v15)
    ],
    products: [
        .library(name: "Data", targets: ["Data"]),
        .library(name: "DataMocks", targets: ["DataMocks"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-http-types", .upToNextMinor(from: "1.0.3")),
        .package(url: "https://github.com/apple/swift-openapi-generator", .upToNextMinor(from: "1.2.0")),
        .package(url: "https://github.com/apple/swift-openapi-runtime", .upToNextMinor(from: "1.2.0")),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", .upToNextMinor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                .product(name: "HTTPTypes", package: "swift-http-types"),
                .product(name: "HTTPTypesFoundation", package: "swift-http-types"),
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession"),
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator")
            ]
        ),
        .target(name: "DataMocks", dependencies: ["Data"]),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
    ]
)
