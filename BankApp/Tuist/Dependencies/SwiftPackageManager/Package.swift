// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/SnapKit/SnapKit.git", .upToNextMinor(from: "5.0.0")),
    ]
)