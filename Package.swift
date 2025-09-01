// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "LagRadarSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "LagRadarKit",
            targets: ["LagRadarKit"])
    ],
    targets: [
        .binaryTarget(
            name: "LagRadarKit",
            url: "https://github.com/user-attachments/files/22076783/LagRadarKit.xcframework.zip",
            checksum: "ab1a7827bb7430623aac8dbe3c0de22b632e59879010b95ec83427d94127d72e"
        )
    ]
)
