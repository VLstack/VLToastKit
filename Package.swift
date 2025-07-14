// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLToastKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLToastKit",
                                targets: ["VLToastKit"])
                      ],
                      dependencies:
                      [
                       .package(url: "https://github.com/VLstack/VLstackNamespace", from: "1.2.0"),
                       .package(url: "https://github.com/VLstack/VLDurationKit", from: "1.0.0")
                      ],
                      targets:
                      [
                       .target(name: "VLToastKit",
                               dependencies: [ "VLstackNamespace", "VLDurationKit" ])
                      ])
