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
                      targets:
                      [
                       .target(name: "VLToastKit")
                      ])
