// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Fucker",
  targets: [
    .target(name: "FuckerCore"),
    .target(name: "Fucker", dependencies: ["FuckerCore"]),
    .testTarget(name: "FuckerTests", dependencies: ["FuckerCore"])
  ]
)
