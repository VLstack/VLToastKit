// swift-tools-version: 6.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let swiftSettings: [ SwiftSetting ] =
[
 .enableUpcomingFeature("ApproachableConcurrency"),
 .enableUpcomingFeature("MemberImportVisibility"),
 .enableUpcomingFeature("ExistentialAny")
]

let package = Package(name: "VLToastKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLToastKit",
                                targets: [ "VLToastKit" ])
                      ],
                      targets:
                      [
                       .target(name: "VLToastKit",
                               swiftSettings: swiftSettings),
                       .testTarget(name: "VLToastKitTests",
                                   dependencies: [ "VLToastKit" ],
                                   swiftSettings: swiftSettings)
                      ])
