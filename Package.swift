// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WebViewCapture",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "WebViewCapture", targets: ["WebViewCapture"])
    ],
    targets: [
        .target(name: "WebViewCapture", path: "Sources/WebViewCapture")
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
