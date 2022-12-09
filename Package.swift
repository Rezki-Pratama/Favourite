// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
 
let package = Package(
    name: "Favourite",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Favourite",
            targets: ["Favourite"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Realm", url: "https://github.com/realm/realm-cocoa.git", from: "5.4.4"),
        .package(url: "https://github.com/Rezki-Pratama/Core.git", from: "0.0.1"),
        .package(url: "https://github.com/Rezki-Pratama/Restaurant.git", from: "0.0.1")
        
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Favourite",
            dependencies: [
                .product(name: "RealmSwift", package: "Realm"),
                "Core",
                "Restaurant"
            ])
    ]
)
